module Web.Controller.Students where

import Web.Controller.Prelude
import Web.View.Students.Index
import Web.View.Students.New
import Web.View.Students.Edit
import Web.View.Students.Show

instance Controller StudentsController where

    -- action StudentsAction = do
    --     students <- query @Student |> fetch
    --     render IndexView { .. }
    --     -- render IndexView students
    --     -- render IndexView { students }
    --     -- render (IndexView students)
    --     -- render $ IndexView students

    action StudentsAction { sortOrder } = do

        putStrLn ("sortOrder: " <> tshow sortOrder)

        students <- query @Student |> fetch
        render IndexView { .. }

    -- action StudentsAction { sortOrder } = do
    --     students <- query @Student |> fetch
    --     render IndexView { .. }

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
                    redirectTo (StudentsAction Nothing)

    action DeleteStudentAction { studentId } = do
        student <- fetch studentId
        deleteRecord student
        setSuccessMessage "Student deleted"
        redirectTo (StudentsAction Nothing)

buildStudent student = student
    |> fill @["lastName","firstMidName","enrollmentDate"]
    |> validateField #firstMidName nonEmpty
    |> validateField #lastName     nonEmpty
