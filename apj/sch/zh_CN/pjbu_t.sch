/* 
================================================================================
檔案代號:pjbu_t
檔案名稱:專案變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbu_t
(
pjbuent       number(5)      ,/* 企業編號 */
pjbu001       varchar2(20)      ,/* 專案編號 */
pjbu002       varchar2(30)      ,/* 本階WBS */
pjbu003       varchar2(20)      ,/* 主要欄立二 */
pjbu004       number(10,0)      ,/* 變更序 */
pjbu005       varchar2(20)      ,/* 變更欄位 */
pjbu006       varchar2(10)      ,/* 變更類型 */
pjbu007       varchar2(255)      ,/* 變更前內容 */
pjbu008       varchar2(255)      ,/* 變更後內容 */
pjbu009       timestamp(0)      ,/* 最後變更時間 */
pjbu010       varchar2(500)      ,/* 欄位說明SQL */
pjbuownid       varchar2(20)      ,/* 資料所有者 */
pjbuowndp       varchar2(10)      ,/* 資料所屬部門 */
pjbucrtid       varchar2(20)      ,/* 資料建立者 */
pjbucrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbucrtdt       timestamp(0)      ,/* 資料創建日 */
pjbumodid       varchar2(20)      ,/* 資料修改者 */
pjbumoddt       timestamp(0)      ,/* 最近修改日 */
pjbucnfid       varchar2(20)      ,/* 資料確認者 */
pjbucnfdt       timestamp(0)      ,/* 資料確認日 */
pjbupstid       varchar2(20)      ,/* 資料過帳者 */
pjbupstdt       timestamp(0)      ,/* 資料過帳日 */
pjbustus       varchar2(10)      ,/* 狀態碼 */
pjbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbu_t add constraint pjbu_pk primary key (pjbuent,pjbu001,pjbu002,pjbu003,pjbu004,pjbu005) enable validate;

create unique index pjbu_pk on pjbu_t (pjbuent,pjbu001,pjbu002,pjbu003,pjbu004,pjbu005);

grant select on pjbu_t to tiptop;
grant update on pjbu_t to tiptop;
grant delete on pjbu_t to tiptop;
grant insert on pjbu_t to tiptop;

exit;
