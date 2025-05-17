<cfsetting enablecfoutputonly="false">
<cfoutput>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="styles.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<cfset prev_tries = arrayNew(2)>
<cfset month_names = listToArray("January,February,March,April,May,June,July,August,September,October,November,December")>

<cfloop index="i" from=1 to=12>
  <cfquery name="pie_data" datasource="cs_db">
    SELECT *
    FROM previous_tries
    WHERE birthMonth = #i#
  </cfquery>
  <cfset prev_tries[i][1] = #pie_data.birthMonth#>
  <cfset prev_tries[i][2] = #pie_data.oneTry#>
  <cfset prev_tries[i][3] = #pie_data.twoTries#>
  <cfset prev_tries[i][4] = #pie_data.wrong#>
</cfloop>

<body>


  <main>


<section class="form-section" style="display: flex; align-items: flex-start; gap: 2rem; margin-top: 2rem;">
  
  <div style="flex: 1;">
    <h3>Enter Your Birth Month</h3>
    <form method="get" action="main/playingGame.cfm" style="display: flex; align-items: center; margin-top:-15%">
      <input type="number" name="birthMonth" placeholder="1-12" min="1" max="12" required />
      <button type="submit">Play</button>
    </form>
  </div>

  <div style="flex: 2;">
    <p>
      Enter your birth month and click play to try to guess the randomized number. Below is how previous tries have ended.
    </p>
    <div style="display: flex; gap: 2rem; margin-top: 1rem;">
      <div style="display: flex; align-items: center; gap: 0.5rem;">
        <div>One Try:</div>
        <div style="width: 60px; height: 20px; background-color: ##006400;"></div>
      </div>
      <div style="display: flex; align-items: center; gap: 0.5rem;">
        <div>Two Tries:</div>
        <div style="width: 60px; height: 20px; background-color: ##90EE90;"></div>
      </div>
      <div style="display: flex; align-items: center; gap: 0.5rem;">
        <div>Wrong:</div>
        <div style="width: 60px; height: 20px; background-color: ##FF6961;"></div>
      </div>
    </div>
</section>


<div class="chart-container">
    <cfloop from="1" to="#ArrayLen(prev_tries)#" index="i">
      <cfif prev_tries[#i#][2] EQ 0 AND prev_tries[#i#][3] EQ 0 AND prev_tries[#i#][4] EQ 0>
        <cfset prev_tries[#i#][2] = 0.001>
        <cfset prev_tries[#i#][3] = 0.001>
        <cfset prev_tries[#i#][4] = 0.001>
      </cfif>

      <cfset canvas_id = "month" & #i#>
      <div class="chart">
      <canvas id="#canvas_id#" width="100" height="150"></canvas>

        <script>
          var ctx = document.getElementById('#canvas_id#').getContext('2d');
          var pieChart = new Chart(ctx, {
            type: 'pie',
            data: {
              datasets: [{
                  data: [#prev_tries[#i#][2]#, #prev_tries[#i#][3]#, #prev_tries[#i#][4]# ],
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
            text: '#month_names[i]#'  }}
          }
        });
    </script>
  </div>
  </cfloop>
</div>
 

  </main>

</body>
</html>
</cfoutput>

