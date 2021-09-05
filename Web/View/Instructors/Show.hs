module Web.View.Instructors.Show where
import Web.View.Prelude

-- data ShowView = ShowView { instructor :: Instructor }

data ShowView = ShowView { instructor :: Include "officeAssignments" Instructor }

instance View ShowView where
    html ShowView { .. } = 
        
        let 
            
            -- ls = get #officeAssignments instructor

            -- ls' = forEach ls renderOfficeAssignment

        in
        
        [hsx|
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href={InstructorsAction}>Instructors</a></li>
                    <li class="breadcrumb-item active">Show Instructor</li>
                </ol>
            </nav>
            <h1>Show Instructor</h1>
            <p>{instructor}</p>
            <p>{get #officeAssignments instructor}</p>

            <p>{forEach (get #officeAssignments instructor) renderOfficeAssignment}</p>

            <!-- <p>{forEach ls renderOfficeAssignment}</p> -->

            <!-- <p>{ls}</p> -->

            <!-- {instructor |> get #officeAssignments} -->

        |]

renderOfficeAssignment :: OfficeAssignment -> Html
renderOfficeAssignment officeAssignment = [hsx|
    {get #location officeAssignment}
|]