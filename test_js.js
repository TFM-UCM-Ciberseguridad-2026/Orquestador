const http = require('http');
http.get('http://localhost:8080/api/infrastructure', (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    try {
      const parsed = JSON.parse(data);
      const vulns = parsed.nodes.filter(n => n.labels.includes('Vulnerability'));
      console.log('Vulns count:', vulns.length);
      const withTtps = vulns.filter(v => v.properties && v.properties.ttps && Array.isArray(v.properties.ttps) && v.properties.ttps.length > 0);
      console.log('Vulns with ttps array:', withTtps.length);
      if (withTtps.length > 0) {
        console.log('First vuln ttps:', withTtps[0].properties.ttps[0]);
      }
    } catch(e) {
      console.error('Parse error:', e);
    }
  });
});
