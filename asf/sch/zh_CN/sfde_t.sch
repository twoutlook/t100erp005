/* 
================================================================================
檔案代號:sfde_t
檔案名稱:發退料需求匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table sfde_t
(
sfdeent       number(5)      ,/* 企業編號 */
sfdesite       varchar2(10)      ,/* 營運據點 */
sfdedocno       varchar2(20)      ,/* 發退料單號 */
sfdeseq       number(10,0)      ,/* 項次 */
sfde001       varchar2(40)      ,/* 需求料號 */
sfde002       varchar2(256)      ,/* 產品特徵 */
sfde003       varchar2(10)      ,/* 單位 */
sfde004       number(20,6)      ,/* 申請數量 */
sfde005       number(20,6)      ,/* 實際數量 */
sfde006       varchar2(10)      ,/* 參考單位 */
sfde007       number(20,6)      ,/* 參考單位申請數量 */
sfde008       number(20,6)      ,/* 參考單位實際數量 */
sfde009       varchar2(1)      ,/* 客供料 */
sfde010       number(5,0)      ,/* 正負 */
sfdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfde_t add constraint sfde_pk primary key (sfdeent,sfdedocno,sfdeseq) enable validate;

create unique index sfde_pk on sfde_t (sfdeent,sfdedocno,sfdeseq);

grant select on sfde_t to tiptop;
grant update on sfde_t to tiptop;
grant delete on sfde_t to tiptop;
grant insert on sfde_t to tiptop;

exit;
