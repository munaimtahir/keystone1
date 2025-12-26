import re
from rest_framework import serializers
from .models import App, Deployment


def normalize_github_url(url):
    """
    Normalize and validate GitHub repository URL.
    - Fix common typos (gothub -> github)
    - Ensure proper format
    - Add .git extension if missing
    - Validate URL structure
    """
    if not url:
        raise serializers.ValidationError("Git URL is required")
    
    url = url.strip()
    
    # Fix common typos
    url = url.replace("gothub.com", "github.com")
    url = url.replace("githib.com", "github.com")
    url = url.replace("githu.com", "github.com")
    
    # Remove trailing slash
    url = url.rstrip('/')
    
    # Validate GitHub URL format
    github_pattern = r'^https?://(www\.)?github\.com/[\w\-\.]+/[\w\-\.]+'
    if not re.match(github_pattern, url):
        raise serializers.ValidationError(
            f"Invalid GitHub URL format. Expected: https://github.com/username/repo-name"
        )
    
    # Ensure URL has repo name (not just username)
    parts = url.split('/')
    if len(parts) < 5 or not parts[4]:  # github.com/username/repo
        raise serializers.ValidationError(
            "GitHub URL must include repository name. Format: https://github.com/username/repo-name"
        )
    
    # Add .git extension if not present (for consistency)
    if not url.endswith('.git'):
        url = url + '.git'
    
    return url


class AppSerializer(serializers.ModelSerializer):
    slug = serializers.ReadOnlyField()
    
    def validate_git_url(self, value):
        """Validate and normalize git URL."""
        return normalize_github_url(value)
    
    class Meta:
        model = App
        fields = "__all__"


class DeploymentSerializer(serializers.ModelSerializer):
    app_name = serializers.CharField(source="app.name", read_only=True)
    
    class Meta:
        model = Deployment
        fields = "__all__"
