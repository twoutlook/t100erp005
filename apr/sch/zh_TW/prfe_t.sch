/* 
================================================================================
檔案代號:prfe_t
檔案名稱:產品價格組申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prfe_t
(
prfeent       number(5)      ,/* 企業編號 */
prfeunit       varchar2(10)      ,/* 應用組織 */
prfesite       varchar2(10)      ,/* 營運據點 */
prfedocno       varchar2(20)      ,/* 申請單號 */
prfedocdt       date      ,/* 申請日期 */
prfe001       varchar2(10)      ,/* 申請類型 */
prfe002       varchar2(10)      ,/* 產品價格組編號 */
prfe003       varchar2(10)      ,/* 版本 */
prfe004       varchar2(20)      ,/* 申請人員 */
prfe005       varchar2(10)      ,/* 申請部門 */
prfeacti       varchar2(1)      ,/* 資料有效碼 */
prfestus       varchar2(10)      ,/* 狀態碼 */
prfeownid       varchar2(20)      ,/* 資料所有者 */
prfeowndp       varchar2(10)      ,/* 資料所屬部門 */
prfecrtid       varchar2(20)      ,/* 資料建立者 */
prfecrtdp       varchar2(10)      ,/* 資料建立部門 */
prfecrtdt       timestamp(0)      ,/* 資料創建日 */
prfemodid       varchar2(20)      ,/* 資料修改者 */
prfemoddt       timestamp(0)      ,/* 最近修改日 */
prfecnfid       varchar2(20)      ,/* 資料確認者 */
prfecnfdt       timestamp(0)      ,/* 資料確認日 */
prfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfe_t add constraint prfe_pk primary key (prfeent,prfedocno) enable validate;

create unique index prfe_pk on prfe_t (prfeent,prfedocno);

grant select on prfe_t to tiptop;
grant update on prfe_t to tiptop;
grant delete on prfe_t to tiptop;
grant insert on prfe_t to tiptop;

exit;
