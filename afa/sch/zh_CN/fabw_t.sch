/* 
================================================================================
檔案代號:fabw_t
檔案名稱:資產調撥歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabw_t
(
fabwent       number(5)      ,/* 企業編碼 */
fabw001       varchar2(20)      ,/* 財產編號 */
fabw002       varchar2(20)      ,/* 附號 */
fabw003       varchar2(20)      ,/* 卡片編號 */
fabw004       varchar2(10)      ,/* 撥出組織 */
fabw005       number(20,6)      ,/* 撥出成本 */
fabw006       number(20,6)      ,/* 撥出累折 */
fabw007       number(20,6)      ,/* 撥出減值準備 */
fabw008       varchar2(10)      ,/* 調撥流水號 */
fabw009       varchar2(10)      ,/* 撥入組織 */
fabw010       varchar2(20)      ,/* 新財產編號 */
fabw011       varchar2(20)      ,/* 新附號 */
fabw012       varchar2(20)      ,/* 新卡片編號 */
fabw013       number(20,6)      ,/* 撥入成本 */
fabw014       number(20,6)      ,/* 撥入累折 */
fabw015       number(20,6)      ,/* 撥入減值準備 */
fabwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabw_t add constraint fabw_pk primary key (fabwent,fabw001,fabw002,fabw003,fabw008) enable validate;

create unique index fabw_pk on fabw_t (fabwent,fabw001,fabw002,fabw003,fabw008);

grant select on fabw_t to tiptop;
grant update on fabw_t to tiptop;
grant delete on fabw_t to tiptop;
grant insert on fabw_t to tiptop;

exit;
