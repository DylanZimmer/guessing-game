<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="../styles.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<cfif #url.won# eq 0>
    <cfquery name="updateWrong" datasource="cs_db">
        UPDATE previous_tries
        SET wrong = wrong + 1
        WHERE birthMonth = '#url.birthMonth#'
    </cfquery>
<cfelseif #url.won# eq 1>
    <cfquery name="updateOneTry" datasource="cs_db">
        UPDATE previous_tries
        SET oneTry = oneTry + 1
        WHERE birthMonth = '#url.birthMonth#'
    </cfquery>
<cfelseif #url.won# eq 2>
    <cfquery name="updateTwoTries" datasource="cs_db">
        UPDATE previous_tries
        SET twoTries = twoTries + 1
        WHERE birthMonth = '#url.birthMonth#'
    </cfquery>
</cfif>

<cfquery name="getMonth" datasource="cs_db">
    SELECT *
    FROM previous_tries
    WHERE birthMonth = '#url.birthMonth#'
</cfquery>

<cfset month_names = listToArray("January,February,March,April,May,June,July,August,September,October,November,December")>
<cfset monthForTitle = month_names[#url.birthMonth#]>


<cfoutput>
<body>

    <div class="chart" style="margin-top:8%;">
    <canvas id="pie_chart" width="250" height="300"></canvas>

        <script>
          var ctx = document.getElementById('pie_chart').getContext('2d');
          var pie_chart = new Chart(ctx, {
            type: 'pie',
            data: {
              datasets: [{
                  data: ['#getMonth.oneTry#', '#getMonth.twoTries#', '#getMonth.wrong#'],
                  backgroundColor: ['##006400', '##90EE90', '##FF6961'],
                  hoverBackgroundColor: ['##004d00', '##66cc66', '##e0554a']
              }]
            },
          options: {
          responsive: false,
          maintainAspectRatio: false,
          plugins: {
          title: {
            display: true,
            text: '#monthForTitle#'  }}
          }
        });
    </script>

    <a href="../index.cfm" style="text-decoration: none;">
        <button>Home</button>
    </a>

</body>
</cfoutput>


</html>