module Web.View.Students.Edit where
import Web.View.Prelude

data EditView = EditView { student :: Student }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={StudentsAction Nothing}>Students</a></li>
                <li class="breadcrumb-item active">Edit Student</li>
            </ol>
        </nav>
        <h1>Edit Student</h1>
        {renderForm student}
    |]

renderForm :: Student -> Html
renderForm student = formFor student [hsx|
    {(textField #lastName)}
    {(textField #firstMidName)}
    {(textField #enrollmentDate)}
    {submitButton}
|]
