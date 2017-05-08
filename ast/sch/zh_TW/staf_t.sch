/* 
================================================================================
檔案代號:staf_t
檔案名稱:費用編號合約輸入條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table staf_t
(
stafent       number(5)      ,/* 企業編號 */
staf001       varchar2(10)      ,/* 費用編號 */
staf002       varchar2(10)      ,/* 經營方式 */
staf003       varchar2(10)      ,/* 控制欄位 */
staf004       varchar2(1)      ,/* 可輸入 */
staf005       varchar2(1)      ,/* 必輸入 */
staf006       varchar2(100)      ,/* 預設值 */
stafownid       varchar2(20)      ,/* 資料所有者 */
stafowndp       varchar2(10)      ,/* 資料所屬部門 */
stafcrtid       varchar2(20)      ,/* 資料建立者 */
stafcrtdp       varchar2(10)      ,/* 資料建立部門 */
stafcrtdt       timestamp(0)      ,/* 資料創建日 */
stafmodid       varchar2(20)      ,/* 資料修改者 */
stafmoddt       timestamp(0)      ,/* 最近修改日 */
stafstus       varchar2(10)      ,/* 狀態碼 */
stafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table staf_t add constraint staf_pk primary key (stafent,staf001,staf002,staf003) enable validate;

create unique index staf_pk on staf_t (stafent,staf001,staf002,staf003);

grant select on staf_t to tiptop;
grant update on staf_t to tiptop;
grant delete on staf_t to tiptop;
grant insert on staf_t to tiptop;

exit;
