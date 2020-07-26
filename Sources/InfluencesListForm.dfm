object InfluencesList: TInfluencesList
  Left = 336
  Top = 234
  BorderStyle = bsToolWindow
  Caption = 'Select Influences To Add:'
  ClientHeight = 436
  ClientWidth = 192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object list: TListBox
    Left = 8
    Top = 8
    Width = 177
    Height = 361
    ExtendedSelect = False
    ItemHeight = 13
    Items.Strings = (
      'k_mul_reload_speed'
      'k_mul_aim_speed'
      'k_mul_activ_speed'
      'k_add_activ_speed'
      'k_mul_fire_disp'
      'k_add_fire_disp'
      'k_mul_hipfire_disp'
      'k_mul_recoil_v'
      'k_add_recoil_v'
      'k_mul_recoil_h'
      'k_add_recoil_h'
      'k_mul_rpm'
      'k_mul_aim_wave'
      'k_mul_weight'
      'k_add_weight'
      'k_mul_cond_per_shot'
      'k_add_cond_per_shot'
      'k_mul_bullet_speed'
      'k_add_bullet_speed'
      'k_mul_bullet_kinetic'
      'k_add_bullet_kinetic'
      'k_mul_bullet_wound'
      'k_add_bullet_wound'
      'k_mul_bullet_hit'
      'k_add_bullet_hit'
      'k_mul_bullet_crit_rnd'
      'k_add_bullet_crit_rnd'
      'k_mul_bullet_shield_stlk'
      'k_add_bullet_shield_stlk'
      'k_mul_bullet_shield_mnst'
      'k_add_bullet_shield_mnst'
      'inv_weight'
      'hit_power'
      'hit_impulse'
      'fire_distance'
      'bullet_speed'
      'rpm'
      'misfire_start_condition'
      'misfire_end_condition'
      'misfire_start_prob'
      'misfire_end_prob'
      'condition_shot_dec'
      'condition_queue_shot_dec'
      'ammo_mag_size'
      'fire_modes'
      'ammo_class'
      'fire_dispersion_base'
      'control_inertion_factor'
      'crosshair_inertion'
      'cam_return'
      'cam_relax_speed'
      'cam_dispersion'
      'cam_dispersion_inc'
      'cam_dispersion_frac'
      'cam_max_angle'
      'cam_max_angle_horz'
      'cam_step_angle_horz'
      'zoom_cam_relax_speed'
      'zoom_cam_dispersion'
      'zoom_cam_dispersion_inc'
      'zoom_cam_dispersion_frac'
      'zoom_cam_max_angle'
      'zoom_cam_max_angle_horz'
      'zoom_cam_step_angle_horz'
      'PDM_disp_base'
      'PDM_disp_vel_factor'
      'PDM_disp_accel_factor'
      'PDM_disp_crouch'
      'PDM_disp_crouch_no_acc'
      'scope_status '
      'scopes_sect'
      'grenade_launcher_status'
      'grenade_launcher_name'
      'grenade_launcher_x'
      'grenade_launcher_y'
      'grenade_class'
      'launch_speed'
      'silencer_status'
      'silencer_name'
      'silencer_x'
      'silencer_y'
      '')
    MultiSelect = True
    TabOrder = 0
  end
  object btn_ok: TButton
    Left = 16
    Top = 400
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btn_okClick
  end
  object btn_close: TButton
    Left = 104
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btn_closeClick
  end
end
