/* 
================================================================================
檔案代號:pjbf_t
檔案名稱:專案WBS裝置預算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbf_t
(
pjbfent       number(5)      ,/* 企業編號 */
pjbf001       varchar2(20)      ,/* 專案編號 */
pjbf002       varchar2(30)      ,/* 本階WBS */
pjbf003       varchar2(20)      ,/* 限定機器 */
pjbf004       varchar2(10)      ,/* 耗用單位 */
pjbf005       number(20,6)      ,/* 耗用數量 */
pjbf006       number(20,6)      ,/* 單位成本率 */
pjbf007       number(20,6)      ,/* 金額 */
pjbf008       varchar2(255)      ,/* 備註 */
pjbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbf009       varchar2(10)      ,/* 稅別 */
pjbf010       number(5,2)      ,/* 稅率 */
pjbf011       number(20,6)      ,/* 原幣含稅金額 */
pjbf012       number(20,6)      ,/* 本幣未稅金額 */
pjbf013       number(20,6)      ,/* 本幣含稅金額 */
pjbf014       varchar2(10)      /* 成本要素 */
);
alter table pjbf_t add constraint pjbf_pk primary key (pjbfent,pjbf001,pjbf002,pjbf003) enable validate;

create unique index pjbf_pk on pjbf_t (pjbfent,pjbf001,pjbf002,pjbf003);

grant select on pjbf_t to tiptop;
grant update on pjbf_t to tiptop;
grant delete on pjbf_t to tiptop;
grant insert on pjbf_t to tiptop;

exit;
