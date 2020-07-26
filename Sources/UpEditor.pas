unit UpEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, texture_loader, Upgrade, StdCtrls, Math, Textinput, InfluencesListForm, strutils;

type
  TUpgradeEditor = class(TForm)
    btn_adv: TButton;
    group_adv: TGroupBox;
    Label7: TLabel;
    label_pp: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edit_inv_name: TEdit;
    edit_inv_descr: TEdit;
    edit_precond_f: TEdit;
    edit_precond_param: TEdit;
    edit_effect_f: TEdit;
    edit_effect_param: TEdit;
    edit_prereq_f: TEdit;
    edit_prereq_tooltip_f: TEdit;
    edit_prereq_params: TEdit;
    group_visualization: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edit_sch_x: TEdit;
    edit_sch_y: TEdit;
    edit_point_x: TEdit;
    edit_point_y: TEdit;
    preview: TImage;
    preview_bevel: TBevel;
    group_general: TGroupBox;
    Label6: TLabel;
    Label5: TLabel;
    edit_name: TEdit;
    combo_property_1: TComboBox;
    Cost: TLabel;
    edit_cost: TEdit;
    Label8: TLabel;
    edit_value_1: TEdit;
    btn_stringeditor: TButton;
    Label16: TLabel;
    edit_inherits: TEdit;
    combo_property_2: TComboBox;
    Label17: TLabel;
    Label18: TLabel;
    edit_value_2: TEdit;
    Label20: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    combo_property_3: TComboBox;
    edit_value_3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure previewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btn_advClick(Sender: TObject);
    procedure btn_stringeditorClick(Sender: TObject);
    procedure edit_costKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edit_value_1Change(Sender: TObject);
    procedure edit_value_2Change(Sender: TObject);
    procedure edit_value_3Change(Sender: TObject);
  private
    { Private declarations }
    _selector:TTextureSelectorForm;
    _base_tex:TPicture;
    _up:TUpgrade;
    _editor:TTextInputForm;
    _param_list:TInfluencesList;

    _last_val_1:string;
    _last_val_2:string;
    _last_val_3:string;

    procedure _UpdateVis();
  public
    procedure SetBaseTexture(tex:TPicture);
    procedure SetUpgrade(up:TUpgrade);
    procedure UpdatePreview();
    { Public declarations }
  end;

implementation
uses Main;
{$R *.dfm}

procedure TUpgradeEditor.FormCreate(Sender: TObject);
var
  sf:TForm;
begin
  if self.Owner is TForm then begin
    sf:=TForm(self.Owner);
    self.Top  := ceil( sf.Top  + (sf.Height - self.Height)/2 );
    self.Left := ceil( sf.Left + (sf.Width  - self.Width )/2 );
    if self.Top<0 then self.Top:=0;
    if self.Left<0 then self.Left:=0;
  end;
  _selector:=TTextureSelectorForm.Create(self);
  _editor:=TTextInputForm.Create(self);
  _param_list:=TInfluencesList.Create(_editor);
end;

procedure TUpgradeEditor.FormDestroy(Sender: TObject);
begin
  _param_list.Free();
  _editor.Free;
  _selector.Free;
end;

procedure TUpgradeEditor.SetBaseTexture(tex: TPicture);
begin
  _base_tex := tex;
end;

procedure TUpgradeEditor.SetUpgrade(up: TUpgrade);
begin
  _up:=up;
end;

procedure TUpgradeEditor.previewClick(Sender: TObject);
begin
  _selector.Init(_base_tex, _up.visual, Rect(_up.visual.GetTopLeft, _up.visual.GetBottomRight));
  _selector.Show();
end;

procedure TUpgradeEditor.FormShow(Sender: TObject);
begin
  if self.Owner is TForm then TForm(self.Owner).Enabled:=false;
  preview.Width:=_up.visual.GetDefault.X;
  preview.Height:=_up.visual.GetDefault.Y;
  preview_bevel.Width:=_up.visual.GetDefault.X;
  preview_bevel.Height:=_up.visual.GetDefault.Y;

  edit_sch_x.Text:=inttostr(_up.coords.X);
  edit_sch_y.Text:=inttostr(_up.coords.Y);
  edit_point_x.Text:=inttostr(_up.point.X);
  edit_point_y.Text:=inttostr(_up.point.Y);


  edit_name.Text:=_up.name;

  combo_property_1.Text:=_up.up_prop_1;
  combo_property_2.Text:=_up.up_prop_2;
  combo_property_3.Text:=_up.up_prop_3;

  edit_inv_name.Text:=_up.inv_name;
  edit_inv_descr.Text:=_up.inv_descr;
  edit_precond_f.Text:=_up.precondition_functor;
  edit_precond_param.Text:=_up.precondition_parameter;
  edit_effect_f.Text:=_up.effect_functor;
  edit_effect_param.Text:=_up.effect_parameter;
  edit_prereq_f.Text:=_up.prereq_functor;
  edit_prereq_tooltip_f.Text:=_up.prereq_tooltip_functor;
  edit_prereq_params.Text:=_up.prereq_params;

  edit_cost.Text:=inttostr(_up.cost);
  edit_value_1.Text:= _up.value_1;
  edit_value_2.Text:= _up.value_2;
  edit_value_3.Text:= _up.value_3;

  edit_inherits.Text:=_up.inherited_section;

  _last_val_1:=_up.value_1;
  _last_val_2:=_up.value_2;
  _last_val_3:=_up.value_3;

  UpdatePreview;
end;

procedure TUpgradeEditor.FormHide(Sender: TObject);
begin
//  if trim(edit_value.Text)='' then edit_value.Text:='0';

  _up.name:=edit_name.Text;
  _up.up_prop_1:=combo_property_1.Text;
  _up.up_prop_2:=combo_property_2.Text;
  _up.up_prop_3:=combo_property_3.Text;
  _up.coords.X:=strtointdef(edit_sch_x.Text, _up.coords.X);
  _up.coords.Y:=strtointdef(edit_sch_y.Text, _up.coords.Y);
  _up.point.X:=strtointdef(edit_point_x.Text, _up.point.X);
  _up.point.Y:=strtointdef(edit_point_y.Text, _up.point.Y);

  _up.inv_name:=edit_inv_name.Text;
  _up.inv_descr:=edit_inv_descr.Text;
  _up.precondition_functor:=edit_precond_f.Text;
  _up.precondition_parameter:=edit_precond_param.Text;
  _up.effect_functor:=edit_effect_f.Text;
  _up.effect_parameter:=edit_effect_param.Text;
  _up.prereq_functor:=edit_prereq_f.Text;
  _up.prereq_tooltip_functor:=edit_prereq_tooltip_f.Text;
  _up.prereq_params:=edit_prereq_params.Text;

  _up.cost:=strtointdef(edit_cost.Text, _up.cost);
  _up.value_1:=edit_value_1.Text;
  _up.value_2:=edit_value_2.Text;
  _up.value_3:=edit_value_3.Text;

  _up.inherited_section:=edit_inherits.Text;

  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=true;
    _UpdateVis();
  end;
end;

procedure TUpgradeEditor._UpdateVis;
begin
  if self.Owner is TMainForm then begin
    TMainForm(self.Owner).UpdateUpgrades();
  end;
end;

procedure TUpgradeEditor.UpdatePreview;
begin
  preview.Picture.Assign(_up.visual.GetPic);
end;




procedure TUpgradeEditor.btn_advClick(Sender: TObject);
begin
  if btn_adv.Caption='>' then begin
    btn_adv.Caption:='<';
    group_adv.Enabled:=true;
    //btn_adv.Left:=600;
    self.ClientWidth:=588;
  end else begin
    btn_adv.Caption:='>';
    group_adv.Enabled:=false;
    //btn_adv.Left:=288;
    self.ClientWidth:=296;
  end;
end;

procedure TUpgradeEditor.btn_stringeditorClick(Sender: TObject);
begin
  _editor.Init(_up.section_params, _param_list);
  _editor.Show();
end;

procedure TUpgradeEditor.edit_costKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9', chr(13), chr(8):
      begin
      end;
  else
    Key:=chr(0);
  end;

end;

procedure TUpgradeEditor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = chr(27) then Close;
end;

procedure TUpgradeEditor.edit_value_1Change(Sender: TObject);
begin
  try
    if (trim(edit_value_1.Text)<>'') then
      strtofloat(edit_value_1.Text+'0');
    _last_val_1:=edit_value_1.Text;
  except
    on E:EConvertError do
      edit_value_1.Text:=_last_val_1;
  end;
end;

procedure TUpgradeEditor.edit_value_2Change(Sender: TObject);
begin
  try
    if (trim(edit_value_2.Text)<>'') then
      strtofloat(edit_value_2.Text+'0');
    _last_val_2:=edit_value_2.Text;
  except
    on E:EConvertError do
      edit_value_2.Text:=_last_val_2;
  end;
end;

procedure TUpgradeEditor.edit_value_3Change(Sender: TObject);
begin
  try
    if (trim(edit_value_3.Text)<>'') then
      strtofloat(edit_value_3.Text+'0');
    _last_val_3:=edit_value_3.Text;
  except
    on E:EConvertError do
      edit_value_3.Text:=_last_val_3;
  end;
end;

end.
