/* 
================================================================================
檔案代號:prci_t
檔案名稱:促銷任務量分配資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prci_t
(
prcient       number(5)      ,/* 企業編號 */
prcisite       varchar2(10)      ,/* 營運據點 */
prciunit       varchar2(10)      ,/* 應用組織 */
prcidocno       varchar2(20)      ,/* 單據編號 */
prcidocdt       date      ,/* 單據日期 */
prci001       varchar2(30)      ,/* 促銷方案 */
prci002       varchar2(30)      ,/* 促銷計劃 */
prci003       varchar2(20)      ,/* 分配人員 */
prci004       varchar2(10)      ,/* 分配部門 */
prci005       varchar2(255)      ,/* 備註 */
prcistus       varchar2(10)      ,/* 狀態碼 */
prciownid       varchar2(20)      ,/* 資料所有者 */
prciowndp       varchar2(10)      ,/* 資料所屬部門 */
prcicrtid       varchar2(20)      ,/* 資料建立者 */
prcicrtdp       varchar2(10)      ,/* 資料建立部門 */
prcicrtdt       timestamp(0)      ,/* 資料創建日 */
prcimodid       varchar2(20)      ,/* 資料修改者 */
prcimoddt       timestamp(0)      ,/* 最近修改日 */
prcicnfid       varchar2(20)      ,/* 資料確認者 */
prcicnfdt       timestamp(0)      ,/* 資料確認日 */
prciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prciud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prci_t add constraint prci_pk primary key (prcient,prcidocno) enable validate;

create unique index prci_pk on prci_t (prcient,prcidocno);

grant select on prci_t to tiptop;
grant update on prci_t to tiptop;
grant delete on prci_t to tiptop;
grant insert on prci_t to tiptop;

exit;
