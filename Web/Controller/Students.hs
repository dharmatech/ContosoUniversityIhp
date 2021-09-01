module Web.Controller.Students where

import Web.Controller.Prelude
import Web.View.Students.Index
import Web.View.Students.New
import Web.View.Students.Edit
import Web.View.Students.Show

instance Controller StudentsController where

    action StudentsAction { sortOrder, currentFilter, searchString, pageIndex } = do

        let currentSort = sortOrder
        
        let nameSort = case sortOrder of
                            Nothing          -> "NameDsc"
                            (Just "NameAsc") -> "NameDsc"
                            _                -> "NameAsc"

        let dateSort = case sortOrder of
                            (Just "DateAsc") -> "DateDsc"
                            _                -> "DateAsc"

        let searchString' = case searchString of
                                Nothing -> currentFilter
                                _       -> searchString

        let pageIndex' = case searchString of
                            Nothing -> pageIndex
                            _       -> Just 1
         
        let _currentFilter = searchString'
                
        students <- case searchString' of
            Nothing -> query @Student |> fetch
            (Just str) -> query @Student 
                |> queryOr
                    (filterWhereILike (#lastName, "%" <> str <> "%"))
                    (filterWhereILike (#firstMidName, "%" <> str <> "%"))
                |> fetch        

        -- let queryBuilder = case searchString' of
        --                     Nothing -> query @Student
        --                     (Just str) -> query @Student 
        --                         |> queryOr
        --                             (filterWhereILike (#lastName, "%" <> str <> "%"))
        --                             (filterWhereILike (#firstMidName, "%" <> str <> "%"))   

        -- students <- case sortOrder of
        --                 (Just "NameAsc") -> queryBuilder |> orderByAsc  #lastName |> fetch
        --                 (Just "NameDsc") -> queryBuilder |> orderByDesc #lastName |> fetch
        --                 (Just "DateAsc") -> queryBuilder |> orderByAsc  #enrollmentDate |> fetch
        --                 (Just "DateDsc") -> queryBuilder |> orderByDesc #enrollmentDate |> fetch
        --                 Nothing -> queryBuilder |> orderByAsc #lastName |> fetch
        --                 _ -> queryBuilder |> orderByAsc #lastName |> fetch

        let pageIndex' = case pageIndex of
                Nothing -> 1
                (Just n) -> n

        let ls = createPaginatedList students pageIndex' 4
                  

          

        -- let students' = students |> orderBy #lastName

        -- students' <- case sortOrder of
        --     (Just "NameAsc") -> students |> orderBy #lastName

        -- render (IndexView (StudentsIndexModel students currentSort nameSort dateSort _currentFilter))

        render (IndexView (StudentsIndexModel ls currentSort nameSort dateSort _currentFilter))

    action NewStudentAction = do
        let student = newRecord
        render NewView { .. }

    -- action NewStudentAction = do
    --     let student = Student { id = Default, firstMidName = "Richard", lastName = "Stallman" }
    --     render NewView { .. }

    action ShowStudentAction { studentId } = do
        student <- fetch studentId
        render ShowView { .. }

    action EditStudentAction { studentId } = do
        student <- fetch studentId
        render EditView { .. }

    action UpdateStudentAction { studentId } = do
        student <- fetch studentId
        student
            |> buildStudent
            |> ifValid \case
                Left student -> render EditView { .. }
                Right student -> do
                    student <- student |> updateRecord
                    setSuccessMessage "Student updated"
                    redirectTo EditStudentAction { .. }

    -- action UpdateStudentAction { studentId } = do
    --     student <- fetch studentId
    --     student
    --         |> fill @["lastName","firstMidName","enrollmentDate"]
    --         |> ifValid \case
    --             Left student -> render EditView { .. }
    --             Right student -> do
    --                 student <- student |> updateRecord
    --                 setSuccessMessage "Student updated"
    --                 redirectTo EditStudentAction { .. }

    action CreateStudentAction = do
        let student = newRecord @Student
        student
            |> buildStudent
            |> ifValid \case
                Left student -> render NewView { .. } 
                Right student -> do
                    student <- student |> createRecord
                    setSuccessMessage "Student created"
                    redirectTo (StudentsAction Nothing Nothing Nothing Nothing)

    action DeleteStudentAction { studentId } = do
        student <- fetch studentId
        deleteRecord student
        setSuccessMessage "Student deleted"
        redirectTo (StudentsAction Nothing Nothing Nothing Nothing)

buildStudent student = student
    |> fill @["lastName","firstMidName","enrollmentDate"]
    |> validateField #firstMidName nonEmpty
    |> validateField #lastName     nonEmpty
