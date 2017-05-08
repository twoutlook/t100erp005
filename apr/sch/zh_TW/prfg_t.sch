/* 
================================================================================
檔案代號:prfg_t
檔案名稱:產品價格組資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prfg_t
(
prfgent       number(5)      ,/* 企業編號 */
prfgunit       varchar2(10)      ,/* 應用組織 */
prfgsite       varchar2(10)      ,/* NO USE */
prfg001       varchar2(10)      ,/* 產品價格組 */
prfg002       varchar2(10)      ,/* 版本 */
prfgstus       varchar2(10)      ,/* 狀態嗎 */
prfgownid       varchar2(20)      ,/* 資料所有者 */
prfgowndp       varchar2(10)      ,/* 資料所屬部門 */
prfgcrtid       varchar2(20)      ,/* 資料建立者 */
prfgcrtdp       varchar2(10)      ,/* 資料建立部門 */
prfgcrtdt       timestamp(0)      ,/* 資料創建日 */
prfgmodid       varchar2(20)      ,/* 資料修改者 */
prfgmoddt       timestamp(0)      ,/* 最近修改日 */
prfgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfg_t add constraint prfg_pk primary key (prfgent,prfg001) enable validate;

create unique index prfg_pk on prfg_t (prfgent,prfg001);

grant select on prfg_t to tiptop;
grant update on prfg_t to tiptop;
grant delete on prfg_t to tiptop;
grant insert on prfg_t to tiptop;

exit;
