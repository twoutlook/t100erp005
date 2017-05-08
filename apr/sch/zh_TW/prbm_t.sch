/* 
================================================================================
檔案代號:prbm_t
檔案名稱:電子秤檔案格式定義明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prbm_t
(
prbment       number(5)      ,/* 企業編號 */
prbmunit       varchar2(10)      ,/* 應用組織 */
prbm001       varchar2(10)      ,/* 電子秤編號 */
prbm002       number(10,0)      ,/* 導出順序號 */
prbm003       varchar2(80)      ,/* 描述 */
prbm004       number(5,0)      ,/* 長度 */
prbm005       varchar2(10)      ,/* 對齊方式 */
prbm006       varchar2(10)      ,/* 填充字符 */
prbm007       varchar2(15)      ,/* 數據來源 */
prbm008       varchar2(20)      ,/* 來源字段名 */
prbm009       varchar2(20)      ,/* 字段類型 */
prbm010       varchar2(100)      ,/* 默認值 */
prbmstus       varchar2(10)      ,/* 狀態 */
prbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbmud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbm011       varchar2(10)      /* 轉換類型 */
);
alter table prbm_t add constraint prbm_pk primary key (prbment,prbm001,prbm002) enable validate;

create unique index prbm_pk on prbm_t (prbment,prbm001,prbm002);

grant select on prbm_t to tiptop;
grant update on prbm_t to tiptop;
grant delete on prbm_t to tiptop;
grant insert on prbm_t to tiptop;

exit;
