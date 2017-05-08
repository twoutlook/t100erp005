/* 
================================================================================
檔案代號:sffa_t
檔案名稱:製程報工單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sffa_t
(
sffaent       number(5)      ,/* 企業編號 */
sffasite       varchar2(10)      ,/* 營運據點 */
sffadocno       varchar2(20)      ,/* 報工單號 */
sffadocdt       date      ,/* 報工日期 */
sffa001       varchar2(10)      ,/* 作業類別 */
sffa002       varchar2(20)      ,/* 報工人員 */
sffa003       varchar2(10)      ,/* 部門 */
sffa004       varchar2(10)      ,/* 報工班別 */
sffa005       varchar2(10)      ,/* 作業編號 */
sffa006       varchar2(10)      ,/* 報工組別 */
sffaownid       varchar2(20)      ,/* 資料所有者 */
sffaowndp       varchar2(10)      ,/* 資料所屬部門 */
sffacrtid       varchar2(20)      ,/* 資料建立者 */
sffacrtdp       varchar2(10)      ,/* 資料建立部門 */
sffacrtdt       timestamp(0)      ,/* 資料創建日 */
sffamodid       varchar2(20)      ,/* 資料修改者 */
sffamoddt       timestamp(0)      ,/* 最近修改日 */
sffacnfid       varchar2(20)      ,/* 資料確認者 */
sffacnfdt       timestamp(0)      ,/* 資料確認日 */
sffastus       varchar2(10)      ,/* 狀態碼 */
sffaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sffaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sffaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sffaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sffaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sffaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sffaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sffaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sffaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sffaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sffaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sffaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sffaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sffaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sffaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sffaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sffaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sffaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sffaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sffaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sffaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sffaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sffaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sffaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sffaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sffaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sffaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sffaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sffaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sffaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sffa_t add constraint sffa_pk primary key (sffaent,sffadocno) enable validate;

create unique index sffa_pk on sffa_t (sffaent,sffadocno);

grant select on sffa_t to tiptop;
grant update on sffa_t to tiptop;
grant delete on sffa_t to tiptop;
grant insert on sffa_t to tiptop;

exit;
