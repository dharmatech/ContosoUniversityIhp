module Web.View.Students.Show where
import Web.View.Prelude

data ShowView = ShowView { student :: Student }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={StudentsAction Nothing Nothing Nothing Nothing}>Students</a></li>
                <li class="breadcrumb-item active">Show Student</li>
            </ol>
        </nav>
        <!-- <h1>Show Student</h1> -->
        <h1>{get #firstMidName student} {get #lastName student}</h1>
        <div>Enrollment Date: {get #enrollmentDate student}</div>
        <!-- <p>{student}</p> -->
    |]
