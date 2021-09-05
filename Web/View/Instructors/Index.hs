module Web.View.Instructors.Index where
import Web.View.Prelude

data IndexView = IndexView { instructors :: [Instructor] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={InstructorsAction}>Instructors</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewInstructorAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Last Name</th>
                        <th>First Name</th>
                        <th>Hire Date</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach instructors renderInstructor}</tbody>
            </table>
        </div>
    |]


renderInstructor :: Instructor -> Html
renderInstructor instructor = [hsx|
    <tr>
        <td>{get #lastName instructor}</td>
        <td>{get #firstMidName instructor}</td>
        <td>{get #hireDate instructor}</td>
        
        <td><a href={ShowInstructorAction (get #id instructor)}>Show</a></td>
        <td><a href={EditInstructorAction (get #id instructor)} class="text-muted">Edit</a></td>
        <td><a href={DeleteInstructorAction (get #id instructor)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
