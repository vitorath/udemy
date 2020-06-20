import React from 'react';
import { reduxForm, Field } from 'redux-form';
import { connect } from 'react-redux';

import { submitUserAction } from '../../../store/actions/user';

import './styles.css';

function Form(props) {
  const { handleSubmit } = props;

  function handleFormSubmit(fields, submitUserAction) {
    submitUserAction(fields);
  }

  return (
    <form className="UserForm" onSubmit={handleSubmit((fields) => handleFormSubmit(fields, submitUserAction))}>
      <label htmlFor="name">
        <span>Name</span>
        <Field id="name" name="nome" type="text" component="input" />
      </label>
      <label htmlFor="name">
        <span>Email</span>
        <Field id="email" name="email" type="text" component="input" />
      </label>
      <button type="submit">Salvar</button>
    </form>
  )
}
 

const UserForm = (reduxForm({
  form: 'userForm'
}))(Form);

const mapStateToProps = state => ({});

const mapDispatchToProps = dispatch => ({
  submitUserAction,
});

export default connect(mapStateToProps, mapDispatchToProps)(UserForm);