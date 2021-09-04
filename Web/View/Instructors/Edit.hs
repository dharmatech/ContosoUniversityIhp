module Web.View.Instructors.Edit where
import Web.View.Prelude

data EditView = EditView { instructor :: Instructor }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={InstructorsAction}>Instructors</a></li>
                <li class="breadcrumb-item active">Edit Instructor</li>
            </ol>
        </nav>
        <h1>Edit Instructor</h1>
        {renderForm instructor}
    |]

renderForm :: Instructor -> Html
renderForm instructor = formFor instructor [hsx|
    {(textField #lastName)}
    {(textField #firstMidName)}
    {(textField #hireDate)}
    {submitButton}
|]
