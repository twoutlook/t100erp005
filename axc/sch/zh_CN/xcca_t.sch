/* 
================================================================================
檔案代號:xcca_t
檔案名稱:期初庫存數量成本開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcca_t
(
xccaent       number(5)      ,/* 企業編號 */
xccald       varchar2(5)      ,/* 帳套 */
xccacomp       varchar2(10)      ,/* 法人組織 */
xcca001       varchar2(1)      ,/* 帳套本位幣順序 */
xcca002       varchar2(30)      ,/* 成本域 */
xcca003       varchar2(10)      ,/* 成本計算類型 */
xcca004       number(5,0)      ,/* 年度 */
xcca005       number(5,0)      ,/* 期別 */
xcca006       varchar2(40)      ,/* 料號 */
xcca007       varchar2(256)      ,/* 特性 */
xcca008       varchar2(30)      ,/* 批號 */
xcca101       number(20,6)      ,/* 當月期末數量 */
xcca102       number(20,6)      ,/* 當月期末金額-金額合計 */
xcca102a       number(20,6)      ,/* 當月期末金額-材料 */
xcca102b       number(20,6)      ,/* 當月期末金額-人工 */
xcca102c       number(20,6)      ,/* 當月期末金額-委外加工 */
xcca102d       number(20,6)      ,/* 當月期末金額-制費一 */
xcca102e       number(20,6)      ,/* 當月期末金額-制費二 */
xcca102f       number(20,6)      ,/* 當月期末金額-制費三 */
xcca102g       number(20,6)      ,/* 當月期末金額-制費四 */
xcca102h       number(20,6)      ,/* 當月期末金額-制費五 */
xcca110       number(20,6)      ,/* 當月期末金額-平均單價 */
xcca110a       number(20,6)      ,/* 當月期末金額-材料平均單價 */
xcca110b       number(20,6)      ,/* 當月期末金額-人工平均單價 */
xcca110c       number(20,6)      ,/* 當月期末金額-委外加工平均單 */
xcca110d       number(20,6)      ,/* 當月期末金額-制費一平均單價 */
xcca110e       number(20,6)      ,/* 當月期末金額-制費二平均單價 */
xcca110f       number(20,6)      ,/* 當月期末金額-制費三平均單價 */
xcca110g       number(20,6)      ,/* 當月期末金額-制費四平均單價 */
xcca110h       number(20,6)      ,/* 當月期末金額-制費五平均單價 */
xccaownid       varchar2(20)      ,/* 資料所有者 */
xccaowndp       varchar2(10)      ,/* 資料所屬部門 */
xccacrtid       varchar2(20)      ,/* 資料建立者 */
xccacrtdp       varchar2(10)      ,/* 資料建立部門 */
xccacrtdt       timestamp(0)      ,/* 資料創建日 */
xccamodid       varchar2(20)      ,/* 資料修改者 */
xccamoddt       timestamp(0)      ,/* 最近修改日 */
xccacnfid       varchar2(20)      ,/* 資料確認者 */
xccacnfdt       timestamp(0)      ,/* 資料確認日 */
xccapstid       varchar2(20)      ,/* 資料過帳者 */
xccapstdt       timestamp(0)      ,/* 資料過帳日 */
xccastus       varchar2(10)      ,/* 狀態碼 */
xccaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcca_t add constraint xcca_pk primary key (xccaent,xccald,xcca001,xcca002,xcca003,xcca004,xcca005,xcca006,xcca007,xcca008) enable validate;

create unique index xcca_pk on xcca_t (xccaent,xccald,xcca001,xcca002,xcca003,xcca004,xcca005,xcca006,xcca007,xcca008);

grant select on xcca_t to tiptop;
grant update on xcca_t to tiptop;
grant delete on xcca_t to tiptop;
grant insert on xcca_t to tiptop;

exit;
