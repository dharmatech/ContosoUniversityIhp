module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

-- data SortOrder = NameAsc | NameDsc | DateAsc | DateDesc | SortNone deriving (Eq, Show, Data)

data StudentsController
    = StudentsAction { sortOrder :: Maybe Text, currentFilter :: Maybe Text, searchString :: Maybe Text, pageIndex :: Maybe Int }
    | NewStudentAction
    | ShowStudentAction { studentId :: !(Id Student) }
    | CreateStudentAction
    | EditStudentAction { studentId :: !(Id Student) }
    | UpdateStudentAction { studentId :: !(Id Student) }
    | DeleteStudentAction { studentId :: !(Id Student) }
    deriving (Eq, Show, Data)

data InstructorsController
    = InstructorsAction
    | NewInstructorAction
    | ShowInstructorAction { instructorId :: !(Id Instructor) }
    | CreateInstructorAction
    | EditInstructorAction { instructorId :: !(Id Instructor) }
    | UpdateInstructorAction { instructorId :: !(Id Instructor) }
    | DeleteInstructorAction { instructorId :: !(Id Instructor) }
    deriving (Eq, Show, Data)
