/* 
================================================================================
檔案代號:pjag_t
檔案名稱:專案報價設備明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjag_t
(
pjagent       number(5)      ,/* 企業編號 */
pjag001       varchar2(20)      ,/* 專案編號 */
pjag002       number(10,0)      ,/* 報價版本 */
pjag003       varchar2(10)      ,/* WBS類型 */
pjag004       varchar2(20)      ,/* 限定機器 */
pjag005       varchar2(10)      ,/* 耗用單位 */
pjag006       number(20,6)      ,/* 耗用數量 */
pjag007       number(20,6)      ,/* 單位成本率 */
pjag008       number(20,6)      ,/* 原幣未稅金額 */
pjag009       number(20,6)      ,/* 原幣含稅金額 */
pjag010       varchar2(255)      ,/* 備註 */
pjag011       varchar2(10)      ,/* 稅別 */
pjagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjagud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjag012       number(5,2)      /* 稅率 */
);
alter table pjag_t add constraint pjag_pk primary key (pjagent,pjag001,pjag002,pjag003,pjag004) enable validate;

create unique index pjag_pk on pjag_t (pjagent,pjag001,pjag002,pjag003,pjag004);

grant select on pjag_t to tiptop;
grant update on pjag_t to tiptop;
grant delete on pjag_t to tiptop;
grant insert on pjag_t to tiptop;

exit;
