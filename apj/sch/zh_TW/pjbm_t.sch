/* 
================================================================================
檔案代號:pjbm_t
檔案名稱:專案活動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjbm_t
(
pjbment       number(5)      ,/* 企業編號 */
pjbm001       varchar2(20)      ,/* 專案編號 */
pjbm002       varchar2(30)      ,/* 活動編號 */
pjbm003       varchar2(10)      ,/* 活動類型 */
pjbm004       varchar2(10)      ,/* 部門編號 */
pjbm005       varchar2(30)      ,/* 前置活動編號 */
pjbm006       varchar2(10)      ,/* 前置活動關係類型 */
pjbm007       varchar2(30)      ,/* 後續活動編號 */
pjbm008       number(15,3)      ,/* 容差時間 */
pjbm009       varchar2(20)      ,/* 負責人員 */
pjbm010       varchar2(10)      ,/* 負責部門 */
pjbm011       varchar2(30)      ,/* 對應WBS編號 */
pjbm012       number(20,6)      ,/* 活動權重因子 */
pjbm013       varchar2(10)      ,/* 計畫完工比例方式 */
pjbm014       varchar2(10)      ,/* 實際完工比例方式 */
pjbm015       number(15,3)      ,/* 標準作業天數 */
pjbm016       number(15,3)      ,/* 最少作業天數 */
pjbm017       date      ,/* 預計開始日期 */
pjbm018       date      ,/* 預計完成日期 */
pjbm019       date      ,/* 最早開始日期 */
pjbm020       date      ,/* 最早完成日期 */
pjbm021       date      ,/* 最晚開始日期 */
pjbm022       date      ,/* 最晚完成日期 */
pjbm023       date      ,/* 實際開始日期 */
pjbm024       date      ,/* 實際完成日期 */
pjbm025       number(20,6)      ,/* 完工率 */
pjbm026       date      ,/* 推算進度更新日期 */
pjbm027       date      ,/* 最新進度更新日期 */
pjbm028       varchar2(20)      ,/* 最新進度更新人員 */
pjbm029       varchar2(10)      ,/* 狀態碼 */
pjbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbm_t add constraint pjbm_pk primary key (pjbment,pjbm001,pjbm002) enable validate;

create unique index pjbm_pk on pjbm_t (pjbment,pjbm001,pjbm002);

grant select on pjbm_t to tiptop;
grant update on pjbm_t to tiptop;
grant delete on pjbm_t to tiptop;
grant insert on pjbm_t to tiptop;

exit;
