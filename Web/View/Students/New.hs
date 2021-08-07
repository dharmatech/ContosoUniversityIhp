module Web.View.Students.New where
import Web.View.Prelude

data NewView = NewView { student :: Student }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={StudentsAction}>Students</a></li>
                <li class="breadcrumb-item active">New Student</li>
            </ol>
        </nav>
        <h1>New Student</h1>
        {renderForm student}
    |]

renderForm :: Student -> Html
renderForm student = formFor student [hsx|
    {(textField #lastName)}
    {(textField #firstMidName)}
    {(textField #enrollmentDate)}
    {submitButton}
|]
