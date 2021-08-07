module Web.View.Students.Show where
import Web.View.Prelude

data ShowView = ShowView { student :: Student }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={StudentsAction}>Students</a></li>
                <li class="breadcrumb-item active">Show Student</li>
            </ol>
        </nav>
        <h1>Show Student</h1>
        <p>{student}</p>
    |]
