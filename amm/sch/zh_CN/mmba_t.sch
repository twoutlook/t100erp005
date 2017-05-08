/* 
================================================================================
檔案代號:mmba_t
檔案名稱:會員卡券調撥單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmba_t
(
mmbaent       number(5)      ,/* 企業編號 */
mmbasite       varchar2(10)      ,/* 營運據點 */
mmbaunit       varchar2(10)      ,/* 應用組織 */
mmbadocno       varchar2(20)      ,/* 單據編號 */
mmbadocdt       date      ,/* 單據日期 */
mmba000       varchar2(10)      ,/* 資料類型 */
mmbastus       varchar2(10)      ,/* 狀態碼 */
mmbaownid       varchar2(20)      ,/* 資料所有者 */
mmbaowndp       varchar2(10)      ,/* 資料所屬部門 */
mmbacrtid       varchar2(20)      ,/* 資料建立者 */
mmbacrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbacrtdt       timestamp(0)      ,/* 資料創建日 */
mmbamodid       varchar2(20)      ,/* 資料修改者 */
mmbamoddt       timestamp(0)      ,/* 最近修改日 */
mmbacnfid       varchar2(20)      ,/* 資料確認者 */
mmbacnfdt       timestamp(0)      ,/* 資料確認日 */
mmbapstid       varchar2(20)      ,/* 資料過帳者 */
mmbapstdt       timestamp(0)      ,/* 資料過帳日 */
mmbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmba_t add constraint mmba_pk primary key (mmbaent,mmbadocno) enable validate;

create unique index mmba_pk on mmba_t (mmbaent,mmbadocno);

grant select on mmba_t to tiptop;
grant update on mmba_t to tiptop;
grant delete on mmba_t to tiptop;
grant insert on mmba_t to tiptop;

exit;
