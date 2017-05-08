/* 
================================================================================
檔案代號:lopa_t
檔案名稱:watchdog檢查紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table lopa_t
(
lopa001       varchar2(20)      ,/* 執行PID */
lopa002       timestamp(0)      ,/* 執行時間 */
lopaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
lopaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
lopaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
lopaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
lopaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
lopaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
lopaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
lopaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
lopaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
lopaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
lopaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
lopaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
lopaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
lopaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
lopaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
lopaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
lopaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
lopaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
lopaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
lopaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
lopaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
lopaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
lopaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
lopaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
lopaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
lopaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
lopaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
lopaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
lopaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
lopaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on lopa_t to tiptop;
grant update on lopa_t to tiptop;
grant delete on lopa_t to tiptop;
grant insert on lopa_t to tiptop;

exit;
