/* 
================================================================================
檔案代號:logx_t
檔案名稱:服務異動記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table logx_t
(
logxent       number(5)      ,/* 企業代碼 */
logx001       timestamp(0)      ,/* 修改時間 */
logx002       varchar2(40)      ,/* 服務規格編號 */
logx003       varchar2(80)      ,/* WS服務名稱 */
logx004       varchar2(10)      ,/* 執行功能 */
logx005       varchar2(20)      ,/* 使用者編號 */
logx006       varchar2(10)      ,/* 修改人員部門 */
logxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logx_t to tiptop;
grant update on logx_t to tiptop;
grant delete on logx_t to tiptop;
grant insert on logx_t to tiptop;

exit;
