/* 
================================================================================
檔案代號:srab_t
檔案名稱:重覆性生產計畫單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srab_t
(
srabent       number(5)      ,/* 企業編號 */
srabsite       varchar2(10)      ,/* 營運據點 */
srab000       number(10,0)      ,/* 版本 */
srab001       varchar2(10)      ,/* 生產計畫 */
srab002       number(5,0)      ,/* 年 */
srab003       number(5,0)      ,/* 月 */
srab004       varchar2(40)      ,/* 料件編號 */
srab005       varchar2(30)      ,/* BOM特性 */
srab006       varchar2(256)      ,/* 產品特徵 */
srab007       varchar2(1)      ,/* 製程管理 */
srab008       varchar2(10)      ,/* 製程編號 */
srab009       date      ,/* 日期 */
srab010       number(20,6)      ,/* 數量 */
srab011       varchar2(10)      ,/* 單位 */
srab012       varchar2(20)      ,/* 重複性工單號碼（FOR成本計算） */
srabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srab_t add constraint srab_pk primary key (srabent,srabsite,srab000,srab001,srab002,srab003,srab004,srab005,srab006,srab009) enable validate;

create unique index srab_pk on srab_t (srabent,srabsite,srab000,srab001,srab002,srab003,srab004,srab005,srab006,srab009);

grant select on srab_t to tiptop;
grant update on srab_t to tiptop;
grant delete on srab_t to tiptop;
grant insert on srab_t to tiptop;

exit;
