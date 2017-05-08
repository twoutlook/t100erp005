/* 
================================================================================
檔案代號:pmbw_t
檔案名稱:採購價格表申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbw_t
(
pmbwent       number(5)      ,/* 企業編號 */
pmbwdocno       varchar2(20)      ,/* 申請單號 */
pmbw010       varchar2(10)      ,/* 變更方式 */
pmbw011       varchar2(40)      ,/* 料件編號 */
pmbw012       varchar2(256)      ,/* 產品特徵 */
pmbw013       varchar2(10)      ,/* 計價單位 */
pmbw014       varchar2(1)      ,/* 參考資料否 */
pmbw015       varchar2(40)      ,/* 參考料號 */
pmbw016       varchar2(256)      ,/* 參考料號產品特徵 */
pmbw017       number(20,6)      ,/* 加金額 */
pmbw018       number(20,6)      ,/* 加百分比 */
pmbw019       number(20,6)      ,/* 標準定價 */
pmbw020       number(20,6)      ,/* 一般採購價 */
pmbw021       number(20,6)      ,/* 警告容差率 */
pmbw022       number(20,6)      ,/* 拒絕容差率 */
pmbwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbwud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmbw031       varchar2(10)      ,/* 系列 */
pmbw032       varchar2(10)      ,/* 產品分類 */
pmbw033       varchar2(10)      ,/* 參考系列 */
pmbw034       varchar2(10)      /* 參考產品分類 */
);
alter table pmbw_t add constraint pmbw_pk primary key (pmbwent,pmbwdocno,pmbw011,pmbw012,pmbw013,pmbw031,pmbw032) enable validate;

create unique index pmbw_pk on pmbw_t (pmbwent,pmbwdocno,pmbw011,pmbw012,pmbw013,pmbw031,pmbw032);

grant select on pmbw_t to tiptop;
grant update on pmbw_t to tiptop;
grant delete on pmbw_t to tiptop;
grant insert on pmbw_t to tiptop;

exit;
