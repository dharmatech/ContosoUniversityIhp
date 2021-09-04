module Web.View.Instructors.New where
import Web.View.Prelude

data NewView = NewView { instructor :: Instructor }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={InstructorsAction}>Instructors</a></li>
                <li class="breadcrumb-item active">New Instructor</li>
            </ol>
        </nav>
        <h1>New Instructor</h1>
        {renderForm instructor}
    |]

renderForm :: Instructor -> Html
renderForm instructor = formFor instructor [hsx|
    {(textField #lastName)}
    {(textField #firstMidName)}
    {(textField #hireDate)}
    {submitButton}
|]
