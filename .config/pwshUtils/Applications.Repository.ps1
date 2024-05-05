class ApplicationsRepository {
    [string] $DataSource
    [Applications] $Applications
    [bool] $nose = $false
    ApplicationsRepository($DataSource, $Applications) {
        Import-Module -Name PSSQLite
        $this.DataSource = $DataSource
        $this.Applications = $Applications
    }
    [array] GetByParam([hashtable] $param) {
        $selectQuery = $this.buildSelectQuery()
        $whereQuery = $this.buildWhereQuery($param)
        $query = "$($selectQuery) $whereQuery"
        $res = Invoke-SqliteQuery -DataSource $this.DataSource -Query $query
        Write-Host $res
        return $res
    }
    [string] buildWhereQuery([hashtable] $param) {
        $query = @()
        $param.GetEnumerator() | ForEach-Object {
            $query += "$($_.Key) = '$($_.Value)'"
        }
        if (-not($this.nose)){
            $query += "i_use_that = 1"
            $query += "installed = 0"
        }
        $query = $query -join " AND "
        $query = "WHERE $query"
        return $query
    }
    [bool] paramIsInColumns([hashtable] $param) {
        # TODO
        return $true
        # $columns = @()
        # $columns += $this.Applications.getColumns()
        # $param.GetEnumerator() | ForEach-Object {
        #     if ($columns -contains $_.Key) {
        #         return $true
        #     }
        # }
        # return $false
    }
    [string] buildSelectQuery() {
        $columns = $this.Applications.getColumns()
        $columns = $columns -join ", "
        return "SELECT $($columns) FROM $($this.Applications.getTableName())"
    }
    [string] buildInsertQuery() {
        $columns = $this.Applications.getColumns()
        $columns = $columns -join ", "
        return "INSERT INTO $($this.Applications.getTableName()) ($($columns))"
    }
    [string] buildUpdateQuery() {
        $columns = $this.Applications.getColumns()
        $columns = $columns -join ", "
        return "UPDATE $($this.Applications.getTableName()) SET $($columns)"
    }
    [void] Save([Applications] $Applications) {
        $query = $this.buildInsertQuery()
        $query = "$($query) VALUES ('$($Applications.id)', '$($Applications.name)', $($Applications.source), $($Applications.i_use_that), $($Applications.installed)"
        Invoke-SqliteQuery -DataSource $this.DataSource -Query $query
    }
    [void] Update([Applications] $Applications) {
        $query = $this.buildUpdateQuery()
        $query = "$($query) WHERE id = '$($Applications.id)'"
        Invoke-SqliteQuery -DataSource $this.DataSource -Query $query
    }
    [void] Delete([Applications] $Applications) {
        $query = "DELETE FROM $($this.Applications.getTableName()) WHERE id = '$($Applications.id)'"
        Invoke-SqliteQuery -DataSource $this.DataSource -Query $query
    }
    [array] GetAll() {
        $selectQuery = $this.buildSelectQuery()
        $query = "$($selectQuery)"
        return Invoke-SqliteQuery -DataSource $this.DataSource -Query $query
    }
    [void] changeNose() {
        $this.nose = -not($this.nose)
    }
}
class Applications {
    [string] $id
    [string] $name
    [string] $source
    [string] $i_use_that
    [string] $installed

    [string] getTableName() {
        return "Applications"
    }

    [array] getColumns() {
        return @("id", "name", "attr_source", "i_use_that", "installed")
    }

    [Applications] getApplications() {
        $it = New-Object Applications
        $it.id = "id"
        $it.name = "name"
        # $it.attr_source = "attr_source"
        $it.i_use_that = "i_use_that"
        $it.installed = "installed"
        return $it
    }
}