/* 
================================================================================
檔案代號:faab_t
檔案名稱:固定資產組織結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faab_t
(
faabent       number(5)      ,/* 企業編號 */
faabownid       varchar2(20)      ,/* 資料所有者 */
faabowndp       varchar2(10)      ,/* 資料所屬部門 */
faabcrtid       varchar2(20)      ,/* 資料建立者 */
faabcrtdp       varchar2(10)      ,/* 資料建立部門 */
faabcrtdt       timestamp(0)      ,/* 資料創建日 */
faabmodid       varchar2(20)      ,/* 資料修改者 */
faabmoddt       timestamp(0)      ,/* 最近修改日 */
faabstus       varchar2(10)      ,/* 狀態碼 */
faab001       varchar2(1)      ,/* 組織類型 */
faab002       varchar2(10)      ,/* 資產中心 */
faab003       number(5,0)      ,/* 版本 */
faab004       varchar2(10)      ,/* 組織編號 */
faab005       varchar2(10)      ,/* 上層組織編號 */
faab006       date      ,/* 生效日期 */
faab007       varchar2(1)      ,/* 執行版本否 */
faabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faab_t add constraint faab_pk primary key (faabent,faab001,faab002,faab003,faab004) enable validate;

create unique index faab_pk on faab_t (faabent,faab001,faab002,faab003,faab004);

grant select on faab_t to tiptop;
grant update on faab_t to tiptop;
grant delete on faab_t to tiptop;
grant insert on faab_t to tiptop;

exit;
