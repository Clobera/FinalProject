package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Comment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "post_id")
	private Post post;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	private String content;

	@Column(name = "comment_date")
	@CreationTimestamp
	private LocalDateTime commentDate;

	private boolean enabled;

	public Comment() {
		super();
	}

	public Comment(int id, Post post, User user, String content, LocalDateTime commentDate, boolean enabled) {
		super();
		this.id = id;
		this.post = post;
		this.user = user;
		this.content = content;
		this.commentDate = commentDate;
		this.enabled = enabled;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDateTime commentDate) {
		this.commentDate = commentDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public int hashCode() {
		return Objects.hash(commentDate, content, enabled, id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Comment other = (Comment) obj;
		return Objects.equals(commentDate, other.commentDate) && Objects.equals(content, other.content)
				&& enabled == other.enabled && id == other.id;
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", post=" + post + ", user=" + user + ", content=" + content + ", commentDate="
				+ commentDate + ", enabled=" + enabled + "]";
	}

}
