module Web.View.Students.Index where
import Web.View.Prelude

data StudentsIndexModel = StudentsIndexModel { 
    students :: [Student], 
    currentSort :: Maybe Text, 
    nameSort :: Maybe Text,
    dateSort :: Maybe Text,
    _currentFilter :: Maybe Text }

data IndexView = IndexView { model :: StudentsIndexModel }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active">
                    <a href={StudentsAction Nothing Nothing Nothing Nothing}>Students</a>
                </li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewStudentAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>                            
                            <a href={StudentsAction 
                                        (get #nameSort model) 
                                        (get #_currentFilter model) 
                                        Nothing 
                                        Nothing}>
                                Last Name
                            </a>
                        </th>
                        
                        <th>First Name</th>

                        <th>
                            <a href={StudentsAction 
                                        (get #dateSort model) 
                                        (get #_currentFilter model) 
                                        Nothing 
                                        Nothing}>
                                Enrollment Date
                            </a>
                        </th>

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
        <td>
            <a href={ShowStudentAction (get #id student)}>
                {get #lastName student}
            </a>
        </td>

        <td>
            {get #firstMidName student}
        </td>

        <td>
            {get #enrollmentDate student}
        </td>
        
        <td>
            <a href={EditStudentAction (get #id student)} class="text-muted">Edit</a> | 
            <a href={DeleteStudentAction (get #id student)} class="js-delete text-muted">Delete</a>
        </td>
        
    </tr>
|]
