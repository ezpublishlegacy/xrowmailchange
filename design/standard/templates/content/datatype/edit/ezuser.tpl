{default attribute_base=ContentObjectAttribute}

{* User ID. *}
<div class="block">
    <label>{'User ID'|i18n( 'design/standard/content/datatype' )}:</label>
    <p>{$attribute.content.contentobject_id}</p>
</div>

{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}

<div class="block">

{* Username. *}
<div class="element">
    <label for="{$id_base}_login">{'Username'|i18n( 'design/standard/content/datatype' )}:</label>
    {if $attribute.content.has_stored_login}
        <input id="{$id_base}_login" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}_stored_login" size="16" value="{$attribute.content.login}" disabled="disabled" />
        <input id="{$id_base}_login_hidden" type="hidden" name="{$attribute_base}_data_user_login_{$attribute.id}" value="{$attribute.content.login}" />
    {else}
        <input id="{$id_base}_login" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}" size="16" value="{$attribute.content.login}" />
    {/if}
</div>

{* Password #1. *}
<div class="element">
    <label for="{$id_base}_password">{'Password'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_password" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_{$attribute.id}" size="16" value="{if $attribute.content.original_password}{$attribute.content.original_password}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
</div>

{* Password #2. *}
<div class="element">
    <label for="{$id_base}_password_confirm">{'Confirm password'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_password_confirm" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_confirm_{$attribute.id}" size="16" value="{if $attribute.content.original_password_confirm}{$attribute.content.original_password_confirm}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
</div>

{* Email. *}
<div class="element">
    <label for="{$id_base}_email">{'Email'|i18n( 'design/standard/content/datatype' )}:</label>
    {if $#object.published|eq(0)}
        <input id="{$id_base}_email" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_email_{$attribute.id}" size="28" value="{$attribute.content.email|wash( xhtml )}" />
    {else}
        <input id="{$id_base}_email" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="hidden" name="{$attribute_base}_data_user_email_{$attribute.id}" size="28" value="{$attribute.content.email|wash( xhtml )}" />
        <input name="new_mail" type="text" value="{if and(is_set(ezhttp().post.new_mail), ezhttp().post.new_mail|ne(""))}{ezhttp().post.new_mail}{elseif and(is_set($attribute.content.email), $attribute.content.email|ne(""))}{$attribute.content.email|wash( xhtml )}{/if}" />{def $new_mail = checkmailchangeprocess($attribute.content.contentobject_id)}{if is_set($new_mail)}({'Email not approved yet: "%mail"'|i18n('extension/xrowmailchange', '', hash( '%mail', $new_mail ))}){/if}
    {/if}
</div>

{* Email #2. Require e-mail confirmation *}
{if ezini( 'UserSettings', 'RequireConfirmEmail' )|eq( 'true' )}
<div class="element">
    <label for="{$id_base}_email_confirm">{'Confirm email'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_email_confirm" type="hidden" name="{$attribute_base}_data_user_email_confirm_{$attribute.id}" value="{cond( ezhttp_hasvariable( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post' ), ezhttp( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post')|wash( xhtml ), $attribute.content.email )}" />
    <input id="new_mail_confirm" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="new_mail_confirm" size="28" value="{if and(is_set(ezhttp().post.new_mail_confirm), ezhttp().post.new_mail_confirm|ne(""))}{ezhttp().post.new_mail_confirm}{elseif and(is_set($attribute.content.email), $attribute.content.email|ne(""))}{$attribute.content.email|wash( xhtml )}{/if}" />
</div>
{/if}

<div class="break"></div><div class="break"></div>
</div>

{* Status *}
<div class="block">
<div class="element">
    <label>{'Current account status:'|i18n( 'design/standard/content/datatype' )}
    {if $attribute.content.is_enabled}
    <span class="userstatus-enabled">{'enabled'|i18n( 'design/standard/content/datatype' )}</span>
    {else}
    <span class="userstatus-disabled"> {'disabled'|i18n( 'design/standard/content/datatype' )}</span>
    {/if}
    </label>
</div>

<div class="break"></div>
</div>

{/default}
