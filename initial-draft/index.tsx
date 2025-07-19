import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import {
  Cloud,
  Database,
  Server,
  Shield,
  Code,
  Mail,
  Phone,
  MapPin,
  Linkedin,
  Github,
  ExternalLink,
  Download,
} from "lucide-react"

export default function CVPage() {
  const skills = [
    { category: "Cloud Platforms", items: ["AWS", "Azure", "Google Cloud", "DigitalOcean"] },
    { category: "Infrastructure", items: ["Terraform", "CloudFormation", "Ansible", "Kubernetes"] },
    { category: "DevOps", items: ["Docker", "Jenkins", "GitLab CI", "GitHub Actions"] },
    { category: "Monitoring", items: ["Prometheus", "Grafana", "CloudWatch", "Datadog"] },
    { category: "Programming", items: ["Python", "Go", "Bash", "JavaScript"] },
    { category: "Databases", items: ["PostgreSQL", "MongoDB", "Redis", "DynamoDB"] },
  ]

  const experience = [
    {
      title: "Senior Cloud Engineer",
      company: "TechCorp Solutions",
      period: "2022 - Present",
      description: "Led cloud migration initiatives and infrastructure automation projects.",
      achievements: [
        "Reduced infrastructure costs by 40% through optimization",
        "Implemented CI/CD pipelines serving 50+ microservices",
        "Designed disaster recovery solutions with 99.9% uptime",
      ],
    },
    {
      title: "Cloud Infrastructure Engineer",
      company: "CloudFirst Inc",
      period: "2020 - 2022",
      description: "Managed multi-cloud environments and automated deployment processes.",
      achievements: [
        "Architected scalable Kubernetes clusters",
        "Automated infrastructure provisioning with Terraform",
        "Implemented comprehensive monitoring and alerting systems",
      ],
    },
    {
      title: "DevOps Engineer",
      company: "StartupXYZ",
      period: "2018 - 2020",
      description: "Built and maintained CI/CD pipelines and cloud infrastructure.",
      achievements: [
        "Migrated legacy applications to containerized architecture",
        "Established security best practices and compliance frameworks",
        "Reduced deployment time from hours to minutes",
      ],
    },
  ]

  const projects = [
    {
      title: "Multi-Cloud Disaster Recovery",
      description: "Designed and implemented a cross-cloud disaster recovery solution using AWS and Azure.",
      tech: ["AWS", "Azure", "Terraform", "Python"],
      link: "#",
    },
    {
      title: "Kubernetes Monitoring Stack",
      description: "Built comprehensive monitoring solution for Kubernetes clusters with custom dashboards.",
      tech: ["Kubernetes", "Prometheus", "Grafana", "Helm"],
      link: "#",
    },
    {
      title: "Infrastructure as Code Framework",
      description: "Created reusable Terraform modules for rapid cloud infrastructure deployment.",
      tech: ["Terraform", "AWS", "GitLab CI", "Go"],
      link: "#",
    },
  ]

  return (
    <div className="min-h-screen bg-gray-950 text-gray-100">
      {/* Header */}
      <header className="border-b border-gray-800 bg-gray-900/50 backdrop-blur-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto px-6 py-6">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white">Alex Johnson</h1>
              <p className="text-xl text-gray-400 mt-1">Senior Cloud Engineer</p>
            </div>
            <Button variant="outline" className="border-gray-700 hover:bg-gray-800 bg-transparent">
              <Download className="w-4 h-4 mr-2" />
              Download CV
            </Button>
          </div>
        </div>
      </header>

      <main className="max-w-4xl mx-auto px-6 py-12 space-y-16">
        {/* About Section */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6 flex items-center">
            <Cloud className="w-6 h-6 mr-3 text-blue-400" />
            About
          </h2>
          <div className="text-gray-300 text-lg leading-relaxed space-y-4">
            <p>
              Passionate cloud engineer with 6+ years of experience designing and implementing scalable cloud
              infrastructure solutions. Specialized in multi-cloud architectures, DevOps practices, and infrastructure
              automation.
            </p>
            <p>
              Proven track record of reducing operational costs, improving system reliability, and accelerating
              development workflows through innovative cloud solutions.
            </p>
          </div>
        </section>

        {/* Contact Info */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6">Contact</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="flex items-center text-gray-300">
              <Mail className="w-5 h-5 mr-3 text-blue-400" />
              alex.johnson@email.com
            </div>
            <div className="flex items-center text-gray-300">
              <Phone className="w-5 h-5 mr-3 text-blue-400" />
              +1 (555) 123-4567
            </div>
            <div className="flex items-center text-gray-300">
              <MapPin className="w-5 h-5 mr-3 text-blue-400" />
              San Francisco, CA
            </div>
            <div className="flex items-center text-gray-300">
              <Linkedin className="w-5 h-5 mr-3 text-blue-400" />
              linkedin.com/in/alexjohnson
            </div>
          </div>
        </section>

        {/* Skills Section */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6 flex items-center">
            <Code className="w-6 h-6 mr-3 text-green-400" />
            Technical Skills
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {skills.map((skillGroup, index) => (
              <Card key={index} className="bg-gray-900 border-gray-800">
                <CardHeader className="pb-3">
                  <CardTitle className="text-lg text-white">{skillGroup.category}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex flex-wrap gap-2">
                    {skillGroup.items.map((skill, skillIndex) => (
                      <Badge
                        key={skillIndex}
                        variant="secondary"
                        className="bg-gray-800 text-gray-300 hover:bg-gray-700"
                      >
                        {skill}
                      </Badge>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>

        {/* Experience Section */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6 flex items-center">
            <Server className="w-6 h-6 mr-3 text-purple-400" />
            Experience
          </h2>
          <div className="space-y-8">
            {experience.map((job, index) => (
              <Card key={index} className="bg-gray-900 border-gray-800">
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <div>
                      <CardTitle className="text-xl text-white">{job.title}</CardTitle>
                      <CardDescription className="text-lg text-blue-400 mt-1">{job.company}</CardDescription>
                    </div>
                    <Badge variant="outline" className="border-gray-600 text-gray-400">
                      {job.period}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-300 mb-4">{job.description}</p>
                  <ul className="space-y-2">
                    {job.achievements.map((achievement, achIndex) => (
                      <li key={achIndex} className="text-gray-400 flex items-start">
                        <span className="text-green-400 mr-2">•</span>
                        {achievement}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>

        {/* Projects Section */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6 flex items-center">
            <Database className="w-6 h-6 mr-3 text-orange-400" />
            Key Projects
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {projects.map((project, index) => (
              <Card key={index} className="bg-gray-900 border-gray-800 hover:border-gray-700 transition-colors">
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <CardTitle className="text-lg text-white">{project.title}</CardTitle>
                    <Button variant="ghost" size="icon" className="text-gray-400 hover:text-white">
                      <ExternalLink className="w-4 h-4" />
                    </Button>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-300 mb-4">{project.description}</p>
                  <div className="flex flex-wrap gap-2">
                    {project.tech.map((tech, techIndex) => (
                      <Badge key={techIndex} variant="outline" className="border-gray-600 text-gray-400">
                        {tech}
                      </Badge>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>

        {/* Certifications */}
        <section>
          <h2 className="text-2xl font-semibold text-white mb-6 flex items-center">
            <Shield className="w-6 h-6 mr-3 text-yellow-400" />
            Certifications
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Card className="bg-gray-900 border-gray-800">
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="font-semibold text-white">AWS Solutions Architect Professional</h3>
                    <p className="text-gray-400 text-sm">Amazon Web Services</p>
                  </div>
                  <Badge className="bg-orange-500/10 text-orange-400 border-orange-500/20">2023</Badge>
                </div>
              </CardContent>
            </Card>
            <Card className="bg-gray-900 border-gray-800">
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="font-semibold text-white">Certified Kubernetes Administrator</h3>
                    <p className="text-gray-400 text-sm">Cloud Native Computing Foundation</p>
                  </div>
                  <Badge className="bg-blue-500/10 text-blue-400 border-blue-500/20">2022</Badge>
                </div>
              </CardContent>
            </Card>
          </div>
        </section>
      </main>

      {/* Footer */}
      <footer className="border-t border-gray-800 bg-gray-900/50 mt-16">
        <div className="max-w-4xl mx-auto px-6 py-8">
          <div className="flex items-center justify-between">
            <p className="text-gray-400">© 2024 Alex Johnson. All rights reserved.</p>
            <div className="flex space-x-4">
              <Button variant="ghost" size="icon" className="text-gray-400 hover:text-white">
                <Github className="w-5 h-5" />
              </Button>
              <Button variant="ghost" size="icon" className="text-gray-400 hover:text-white">
                <Linkedin className="w-5 h-5" />
              </Button>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
