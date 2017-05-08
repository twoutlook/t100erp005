/* 
================================================================================
檔案代號:prcg_t
檔案名稱:促銷任務量申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prcg_t
(
prcgent       number(5)      ,/* 企業編號 */
prcgunit       varchar2(10)      ,/* 應用組織 */
prcgsite       varchar2(10)      ,/* 營運據點 */
prcgdocno       varchar2(20)      ,/* 單據編號 */
prcgdocdt       date      ,/* 單據日期 */
prcg001       varchar2(30)      ,/* 促銷方案 */
prcg002       varchar2(30)      ,/* 促銷計劃 */
prcg003       varchar2(20)      ,/* 業務人員 */
prcg004       varchar2(10)      ,/* 業務部門 */
prcg005       varchar2(255)      ,/* 備註 */
prcgstus       varchar2(10)      ,/* 狀態碼 */
prcgownid       varchar2(20)      ,/* 資料所有者 */
prcgowndp       varchar2(10)      ,/* 資料所屬部門 */
prcgcrtid       varchar2(20)      ,/* 資料建立者 */
prcgcrtdp       varchar2(10)      ,/* 資料建立部門 */
prcgcrtdt       timestamp(0)      ,/* 資料創建日 */
prcgmodid       varchar2(20)      ,/* 資料修改者 */
prcgmoddt       timestamp(0)      ,/* 最近修改日 */
prcgcnfid       varchar2(20)      ,/* 資料確認者 */
prcgcnfdt       timestamp(0)      ,/* 資料確認日 */
prcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcg_t add constraint prcg_pk primary key (prcgent,prcgdocno) enable validate;

create unique index prcg_pk on prcg_t (prcgent,prcgdocno);

grant select on prcg_t to tiptop;
grant update on prcg_t to tiptop;
grant delete on prcg_t to tiptop;
grant insert on prcg_t to tiptop;

exit;
