/* 
================================================================================
檔案代號:qcaf_t
檔案名稱:管制圖管製作業因數表檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcaf_t
(
qcafstus       varchar2(10)      ,/* 狀態碼 */
qcafent       number(5)      ,/* 企業編號 */
qcaf002       number(5,3)      ,/* Xbar管制界限因素 A */
qcaf003       number(5,3)      ,/* Xbar管制界限因素 A1 */
qcaf004       number(5,3)      ,/* Xbar管制界限因素 A2 */
qcaf005       number(5,3)      ,/* 標準差管制界限因數 b */
qcaf006       number(5,3)      ,/* 標準差管制界限因數 B1 */
qcaf007       number(5,3)      ,/* 標準差管制界限因數 B2 */
qcaf008       number(5,3)      ,/* 標準差管制界限因數 B3 */
qcaf009       number(5,3)      ,/* 標準差管制界限因數 B4 */
qcaf010       number(5,3)      ,/* R管制界限因數 d2 */
qcaf011       number(5,3)      ,/* R管制界限因數 d3 */
qcaf012       number(5,3)      ,/* R管制界限因數 D1 */
qcaf013       number(5,3)      ,/* R管制界限因數 D2 */
qcaf014       number(5,3)      ,/* R管制界限因數 D3 */
qcaf015       number(5,3)      ,/* R管制界限因數 D4 */
qcaf001       number(10,0)      ,/* 樣本數 */
qcafownid       varchar2(20)      ,/* 資料所有者 */
qcafowndp       varchar2(10)      ,/* 資料所屬部門 */
qcafcrtid       varchar2(20)      ,/* 資料建立者 */
qcafcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcafcrtdt       timestamp(0)      ,/* 資料創建日 */
qcafmodid       varchar2(20)      ,/* 資料修改者 */
qcafmoddt       timestamp(0)      ,/* 最近修改日 */
qcafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcaf_t add constraint qcaf_pk primary key (qcafent,qcaf001) enable validate;

create unique index qcaf_pk on qcaf_t (qcafent,qcaf001);

grant select on qcaf_t to tiptop;
grant update on qcaf_t to tiptop;
grant delete on qcaf_t to tiptop;
grant insert on qcaf_t to tiptop;

exit;
