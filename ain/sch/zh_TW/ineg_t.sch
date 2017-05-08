/* 
================================================================================
檔案代號:ineg_t
檔案名稱:盤點資料維護表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table ineg_t
(
inegent       number(5)      ,/* 企業編號 */
inegunit       varchar2(10)      ,/* 應用組織 */
inegsite       varchar2(10)      ,/* 營運據點 */
inegdocno       varchar2(20)      ,/* 單據編號 */
inegdocdt       date      ,/* 單據日期 */
ineg001       varchar2(1)      ,/* 單據類型 */
ineg002       varchar2(20)      ,/* 盤點計劃 */
ineg003       date      ,/* 盤點日期 */
ineg004       varchar2(20)      ,/* 盤點人員 */
ineg005       varchar2(10)      ,/* 盤點部門 */
ineg006       varchar2(20)      ,/* 監盤人員 */
ineg007       varchar2(10)      ,/* 監盤部門 */
inegstus       varchar2(10)      ,/* 狀態 */
inegownid       varchar2(20)      ,/* 資料所屬者 */
inegowndp       varchar2(10)      ,/* 資料所有部門 */
inegcrtid       varchar2(20)      ,/* 資料建立者 */
inegcrtdp       varchar2(10)      ,/* 資料建立部門 */
inegcrtdt       timestamp(0)      ,/* 資料創建日 */
inegmodid       varchar2(20)      ,/* 資料修改者 */
inegmoddt       timestamp(0)      ,/* 最近修改日 */
inegcnfid       varchar2(20)      ,/* 資料確認者 */
inegcnfdt       timestamp(0)      ,/* 資料確認日 */
inegpstid       varchar2(20)      ,/* 資料過帳者 */
inegpstdt       timestamp(0)      ,/* 資料過帳日 */
inegud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inegud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inegud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inegud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inegud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inegud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inegud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inegud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inegud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inegud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inegud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inegud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inegud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inegud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inegud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inegud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inegud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inegud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inegud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inegud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inegud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inegud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inegud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inegud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inegud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inegud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inegud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inegud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inegud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inegud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ineg008       varchar2(10)      ,/* 庫位編號 */
ineg009       varchar2(10)      ,/* 管理品類 */
ineg010       varchar2(10)      ,/* 來源類型 */
ineg011       varchar2(20)      /* 來源單號 */
);
alter table ineg_t add constraint ineg_pk primary key (inegent,inegsite,inegdocno) enable validate;

create unique index ineg_pk on ineg_t (inegent,inegsite,inegdocno);

grant select on ineg_t to tiptop;
grant update on ineg_t to tiptop;
grant delete on ineg_t to tiptop;
grant insert on ineg_t to tiptop;

exit;
