module Web.Controller.Instructors where

import Web.Controller.Prelude
import Web.View.Instructors.Index
import Web.View.Instructors.New
import Web.View.Instructors.Edit
import Web.View.Instructors.Show

instance Controller InstructorsController where
    action InstructorsAction = do
        instructors <- query @Instructor |> fetch
        render IndexView { .. }

    action NewInstructorAction = do
        let instructor = newRecord
        render NewView { .. }

    action ShowInstructorAction { instructorId } = do
        instructor <- fetch instructorId
        render ShowView { .. }

    action EditInstructorAction { instructorId } = do
        instructor <- fetch instructorId
        render EditView { .. }

    action UpdateInstructorAction { instructorId } = do
        instructor <- fetch instructorId
        instructor
            |> buildInstructor
            |> ifValid \case
                Left instructor -> render EditView { .. }
                Right instructor -> do
                    instructor <- instructor |> updateRecord
                    setSuccessMessage "Instructor updated"
                    redirectTo EditInstructorAction { .. }

    action CreateInstructorAction = do
        let instructor = newRecord @Instructor
        instructor
            |> buildInstructor
            |> ifValid \case
                Left instructor -> render NewView { .. } 
                Right instructor -> do
                    instructor <- instructor |> createRecord
                    setSuccessMessage "Instructor created"
                    redirectTo InstructorsAction

    action DeleteInstructorAction { instructorId } = do
        instructor <- fetch instructorId
        deleteRecord instructor
        setSuccessMessage "Instructor deleted"
        redirectTo InstructorsAction

buildInstructor instructor = instructor
    |> fill @["lastName","firstMidName","hireDate"]
