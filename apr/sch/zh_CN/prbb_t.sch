/* 
================================================================================
檔案代號:prbb_t
檔案名稱:市場調查計畫資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbb_t
(
prbbent       number(5)      ,/* 企業編號 */
prbbunit       varchar2(10)      ,/* 應用組織 */
prbbsite       varchar2(10)      ,/* 營運據點 */
prbbdocno       varchar2(20)      ,/* 單據編號 */
prbbdocdt       date      ,/* 單據日期 */
prbb001       number(10)      ,/* 市調類型 */
prbb002       varchar2(10)      ,/* 市調門店 */
prbb003       varchar2(10)      ,/* 競爭門店 */
prbb004       date      ,/* 開始日期 */
prbb005       date      ,/* 結束日期 */
prbb006       varchar2(20)      ,/* 人員 */
prbb007       varchar2(10)      ,/* 部門 */
prbb008       varchar2(255)      ,/* 備註 */
prbbstus       varchar2(10)      ,/* 狀態 */
prbbownid       varchar2(20)      ,/* 資料所有者 */
prbbowndp       varchar2(10)      ,/* 資料所屬部門 */
prbbcrtid       varchar2(20)      ,/* 資料建立者 */
prbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
prbbcrtdt       timestamp(0)      ,/* 資料創建日 */
prbbmodid       varchar2(20)      ,/* 資料修改者 */
prbbmoddt       timestamp(0)      ,/* 最近修改日 */
prbbcnfid       varchar2(20)      ,/* 資料確認者 */
prbbcnfdt       timestamp(0)      ,/* 資料確認日 */
prbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbb_t add constraint prbb_pk primary key (prbbent,prbbdocno) enable validate;

create unique index prbb_pk on prbb_t (prbbent,prbbdocno);

grant select on prbb_t to tiptop;
grant update on prbb_t to tiptop;
grant delete on prbb_t to tiptop;
grant insert on prbb_t to tiptop;

exit;
