module Web.Controller.Students where

import Web.Controller.Prelude
import Web.View.Students.Index
import Web.View.Students.New
import Web.View.Students.Edit
import Web.View.Students.Show

instance Controller StudentsController where

    action StudentsAction { sortOrder, currentFilter, searchString, pageIndex } = do
                
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
                        
        -- students <- case searchString' of
        --     Nothing -> query @Student |> fetch
        --     (Just str) -> query @Student 
        --         |> queryOr
        --             (filterWhereILike (#lastName, "%" <> str <> "%"))
        --             (filterWhereILike (#firstMidName, "%" <> str <> "%"))
        --         |> fetch        

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





        -- students <- case searchString' of

        --     Nothing -> query @Student 
        --         |> (case sortOrder of
        --                 (Just "NameAsc") -> orderByAsc #lastName
        --                 (Just "NameDsc") -> orderByDesc #lastName
        --                 (Just "DateAsc") -> orderByAsc  #enrollmentDate
        --                 (Just "DateDsc") -> orderByDesc #enrollmentDate
        --                 Nothing -> orderByAsc #lastName
        --                 _ -> orderByAsc #lastName)
        --         |> fetch

        --     (Just str) -> query @Student 
        --         |> queryOr
        --             (filterWhereILike (#lastName, "%" <> str <> "%"))
        --             (filterWhereILike (#firstMidName, "%" <> str <> "%"))
        --         |> (case sortOrder of
        --                 (Just "NameAsc") -> orderByAsc #lastName
        --                 (Just "NameDsc") -> orderByDesc #lastName
        --                 (Just "DateAsc") -> orderByAsc  #enrollmentDate
        --                 (Just "DateDsc") -> orderByDesc #enrollmentDate
        --                 Nothing -> orderByAsc #lastName
        --                 _ -> orderByAsc #lastName)
        --         |> fetch    


        -- let queryA = query @Student |> queryOr (filterWhereILike (#lastName, "%")) (filterWhereILike (#firstMidName, "%"))

        -- let queryB = query @Student |> queryOr (filterWhereILike (#lastName, "%" <> "abc" <> "%")) (filterWhereILike (#firstMidName, "%" <> "xyz" <> "%"))



        -- let sortClause q = (case sortOrder of
        --                     (Just "NameAsc") -> orderByAsc #lastName
        --                     (Just "NameDsc") -> orderByDesc #lastName
        --                     (Just "DateAsc") -> orderByAsc  #enrollmentDate
        --                     (Just "DateDsc") -> orderByDesc #enrollmentDate
        --                     Nothing -> orderByAsc #lastName
        --                     _ -> orderByAsc #lastName)                

        -- students <- case searchString' of

        --     Nothing -> query @Student 
        --         |> queryOr
        --             (filterWhereILike (#lastName, "%"))
        --             (filterWhereILike (#firstMidName, "%"))
        --         |> sortClause (query @Student)
        --         |> fetch

        --     (Just str) -> query @Student 
        --         |> queryOr
        --             (filterWhereILike (#lastName, "%" <> str <> "%"))
        --             (filterWhereILike (#firstMidName, "%" <> str <> "%"))
        --         |> sortClause (query @Student)
        --         |> fetch    

        -- let pageIndex'' = case pageIndex' of
        --         Nothing -> 1
        --         (Just n) -> n




        let sortClause q = (case sortOrder of
                            (Just "NameAsc") -> orderByAsc #lastName
                            (Just "NameDsc") -> orderByDesc #lastName
                            (Just "DateAsc") -> orderByAsc  #enrollmentDate
                            (Just "DateDsc") -> orderByDesc #enrollmentDate
                            Nothing -> orderByAsc #lastName
                            _ -> orderByAsc #lastName)                

        students <- case searchString' of

            Nothing -> query @Student 
                |> sortClause (query @Student)
                |> fetch

            (Just str) -> query @Student 
                |> queryOr
                    (filterWhereILike (#lastName, "%" <> str <> "%"))
                    (filterWhereILike (#firstMidName, "%" <> str <> "%"))
                |> sortClause (query @Student)
                |> fetch    

        let pageIndex'' = case pageIndex' of
                Nothing -> 1
                (Just n) -> n








        -- let ls = createPaginatedList students pageIndex' 4
        
        -- let students' = students |> orderBy #lastName

        -- students' <- case sortOrder of
        --     (Just "NameAsc") -> students |> orderBy #lastName
                
        render (IndexView (StudentsIndexModel {
            students = createPaginatedList students pageIndex'' 4,
            currentSort = sortOrder,
            nameSort = nameSort,
            dateSort = dateSort,
            _currentFilter = searchString'
            }))

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
