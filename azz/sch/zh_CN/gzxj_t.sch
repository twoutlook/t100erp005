/* 
================================================================================
檔案代號:gzxj_t
檔案名稱:使用者最近使用相異作業紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxj_t
(
gzxjent       number(5)      ,/* 企業編號 */
gzxj001       varchar2(20)      ,/* 使用者編號 */
gzxj002       timestamp(0)      ,/* 執行時間 */
gzxj003       varchar2(20)      ,/* 作業編號 */
gzxjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on gzxj_t to tiptop;
grant update on gzxj_t to tiptop;
grant delete on gzxj_t to tiptop;
grant insert on gzxj_t to tiptop;

exit;
