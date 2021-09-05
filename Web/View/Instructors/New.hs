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
    <!-- {(textField #officeAssignments)} -->

    <div class="form-group" id="form-group-instructor_officeAssignment">
        <label class for="instructor_officeAssignment">Office Assignment</label>
        <!-- <input type="text" name="officeAssignment" placeholder id="instructor_officeAssignment" class="form-control"> -->
        <input type="text" name="location" placeholder id="instructor_officeAssignment" class="form-control">
    </div>

    {submitButton}
|]
