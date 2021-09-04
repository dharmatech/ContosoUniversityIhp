module Web.View.Instructors.Show where
import Web.View.Prelude

data ShowView = ShowView { instructor :: Instructor }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={InstructorsAction}>Instructors</a></li>
                <li class="breadcrumb-item active">Show Instructor</li>
            </ol>
        </nav>
        <h1>Show Instructor</h1>
        <p>{instructor}</p>
    |]
