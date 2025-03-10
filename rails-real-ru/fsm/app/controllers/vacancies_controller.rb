# frozen_string_literal: true

class VacanciesController < ApplicationController
  before_action :set_vacancy, only: %i[publish archive]

  def index
    @on_moderate = Vacancy.on_moderate
    @published = Vacancy.published
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # BEGIN
  def publish
    if @vacancy.may_publish?
      @vacancy.publish!
      redirect_to vacancies_url, notice: 'Вакансия опубликована.'
    else
      redirect_to vacancies_url, alert: 'Нельзя опубликовать эту вакансию.'
    end
  end

  def archive
    if @vacancy.may_archive?
      @vacancy.archive!
      redirect_to vacancies_url, notice: 'Вакансия отправлена в архив.'
    else
      redirect_to vacancies_url, alert: 'Нельзя архивировать эту вакансию.'
    end
  end
  # END

  private
  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params
    params.require(:vacancy).permit(:title, :description)
  end
end
