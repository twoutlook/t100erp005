/* 
================================================================================
檔案代號:prck_t
檔案名稱:促銷產品數量申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prck_t
(
prckent       number(5)      ,/* 企業編號 */
prckunit       varchar2(10)      ,/* 應用組織 */
prcksite       varchar2(10)      ,/* 營運據點 */
prckdocno       varchar2(20)      ,/* 單據編號 */
prckdocdt       date      ,/* 單據日期 */
prck001       varchar2(30)      ,/* 促銷方案 */
prck002       varchar2(30)      ,/* 促銷計劃 */
prck003       varchar2(20)      ,/* 業務人員 */
prck004       varchar2(10)      ,/* 業務部門 */
prck005       varchar2(255)      ,/* 備註 */
prckstus       varchar2(10)      ,/* 狀態碼 */
prckownid       varchar2(20)      ,/* 資料所有者 */
prckowndp       varchar2(10)      ,/* 資料所屬部門 */
prckcrtid       varchar2(20)      ,/* 資料建立者 */
prckcrtdp       varchar2(10)      ,/* 資料建立部門 */
prckcrtdt       timestamp(0)      ,/* 資料創建日 */
prckmodid       varchar2(20)      ,/* 資料修改者 */
prckmoddt       timestamp(0)      ,/* 最近修改日 */
prckcnfid       varchar2(20)      ,/* 資料確認者 */
prckcnfdt       timestamp(0)      ,/* 資料確認日 */
prckud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prckud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prckud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prckud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prckud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prckud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prckud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prckud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prckud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prckud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prckud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prckud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prckud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prckud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prckud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prckud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prckud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prckud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prckud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prckud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prckud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prckud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prckud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prckud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prckud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prckud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prckud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prckud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prckud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prckud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prck_t add constraint prck_pk primary key (prckent,prckdocno) enable validate;

create unique index prck_pk on prck_t (prckent,prckdocno);

grant select on prck_t to tiptop;
grant update on prck_t to tiptop;
grant delete on prck_t to tiptop;
grant insert on prck_t to tiptop;

exit;
