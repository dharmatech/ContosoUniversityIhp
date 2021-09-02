module Web.View.Students.Index where
import Web.View.Prelude

----------------------------------------------------------------------
data PaginatedList = PaginatedList {
    items :: [Student],
    pageIndex :: Int,
    totalPages :: Int    
}

hasPreviousPage :: PaginatedList -> Bool
hasPreviousPage ls = get #pageIndex ls > 1

hasNextPage :: PaginatedList -> Bool
hasNextPage ls = get #pageIndex ls < get #totalPages ls

-- newPaginatedList :: [Student] -> Int -> Int -> Int -> PaginatedList
-- newPaginatedList items count pageIndex pageSize =
--     PaginatedList {
--         items = items,
--         pageIndex = pageIndex,
--         totalPages = ceiling (fromIntegral count / fromIntegral pageSize)
--     }

-- createPaginatedList :: [Student] -> Int -> Int -> PaginatedList
-- createPaginatedList source pageIndex pageSize =
--     let
--         count = length source
--         items = take pageSize (drop ((pageIndex - 1) * pageSize) source)
--     in
--         newPaginatedList items count pageIndex pageSize

createPaginatedList :: [Student] -> Int -> Int -> PaginatedList
createPaginatedList source pageIndex pageSize =
    let
        count = length source
    in
        PaginatedList {
            items = take pageSize (drop ((pageIndex - 1) * pageSize) source),
            pageIndex = pageIndex,
            totalPages = ceiling (fromIntegral count / fromIntegral pageSize)
        }
----------------------------------------------------------------------
data StudentsIndexModel = StudentsIndexModel { 
    -- students :: [Student], 
    students :: PaginatedList, 
    currentSort :: Maybe Text, 
    nameSort :: Maybe Text,
    dateSort :: Maybe Text,
    _currentFilter :: Maybe Text }

data IndexView = IndexView { model :: StudentsIndexModel }

-- abc :: StudentsIndexModel -> [Student]
-- abc m =
--     get #items (get #students m)

-- renderForm :: Student -> Html
-- renderForm student = formFor student [hsx|
    
-- |]

instance View IndexView where
    html IndexView { .. } = 
        
        let 
            ls = get #items (get #students model)
            prevPageIndex =  Just (get #pageIndex (get #students model) - 1)
            nextPageIndex =  Just (get #pageIndex (get #students model) + 1)
            prevDisabled = (if hasPreviousPage (get #students model) then "" else "disabled") :: Text
            nextDisabled = (if hasNextPage (get #students model) then "" else "disabled") :: Text
        in
              
        [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active">
                    <a href={StudentsAction Nothing Nothing Nothing Nothing}>Students</a>
                </li>
            </ol>
        </nav>

        <h1>
            Index 
            <a href={pathTo NewStudentAction} class="btn btn-primary ml-4">
                + New
            </a>
        </h1>

        <form method="get" action="/Students">
            <div class="form-actions no-color">
                <p>
                    Find by name:
                    <input type="text" name="searchString" />
                    <input type="submit" value="Search" class="btn btn-primary" />
                     | 
                    <a href={StudentsAction Nothing Nothing Nothing Nothing}>
                        Back to full list
                    </a>
                </p>
            </div>
        </form>

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
                <tbody>{forEach ls renderStudent}</tbody>
            </table>
        </div>

        <a href={StudentsAction 
                    (get #currentSort model)
                    (get #_currentFilter model)
                    Nothing
                    prevPageIndex}
            class={"btn btn-primary " <> prevDisabled}
                    >
            Previous
        </a>
        
        <a href={StudentsAction 
                    (get #currentSort model)
                    (get #_currentFilter model)
                    Nothing
                    nextPageIndex}
            class={"btn btn-primary " <> nextDisabled}
                    >
            Next
        </a>
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
