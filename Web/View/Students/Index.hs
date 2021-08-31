module Web.View.Students.Index where
import Web.View.Prelude

-- data IndexView = IndexView { students :: [Student], sortOrder :: Maybe Text }

data StudentsIndexModel = StudentsIndexModel { students :: [Student], currentSort :: Maybe Text, nameSort :: Maybe Text }

data IndexView = IndexView { model :: StudentsIndexModel }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={StudentsAction Nothing}>Students</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewStudentAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <a href="/Students">
                                Student
                            </a>

                            <a href={StudentsAction (get #nameSort model)}>
                                Student
                            </a>



                        </th>
                        <!-- <th></th> -->
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach (get #students model) renderStudent}</tbody>
            </table>
        </div>
    |]

renderStudent :: Student -> Html
renderStudent student = [hsx|
    <tr>
        <!-- <td>{student}</td> -->

        <td>
            <a href={ShowStudentAction (get #id student)}>
                {get #firstMidName student} {get #lastName student}
            </a>
        </td>

        <!-- <td><a href={ShowStudentAction (get #id student)}>Show</a></td> -->

        <td><a href={EditStudentAction (get #id student)} class="text-muted">Edit</a></td>
        <td><a href={DeleteStudentAction (get #id student)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]

-- Keeping th and td data together.

-- [
--    ("Student", (\student -> EditStudentAction (get #id student)))
--] 

-- [
--     (
--         [hsx|<th>Student</th>|], 
-- 
--         (\student ->
--             [hsx|
--                 <a href={ShowStudentAction (get #id student)}>
--                     {get #firstMidName student} {get #lastName student}
--                 </a>            
--             |])
--     ),
--     
--     (
--         [hsx|<th></th>|], 
-- 
--         (\student ->
--             [hsx|
--                 <a href={EditStudentAction (get #id student)} class="text-muted">Edit</a>
--             |])
--     ),
-- 
--     ...
-- 
-- ]