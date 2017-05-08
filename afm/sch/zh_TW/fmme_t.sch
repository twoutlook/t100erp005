/* 
================================================================================
檔案代號:fmme_t
檔案名稱:交易市場檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmme_t
(
fmmeent       number(5)      ,/* 企業編號 */
fmme001       varchar2(10)      ,/* 交易市場編號 */
fmme002       varchar2(80)      ,/* 市場描述 */
fmmeownid       varchar2(20)      ,/* 資料所有者 */
fmmeowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmecrtid       varchar2(20)      ,/* 資料建立者 */
fmmecrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmecrtdt       timestamp(0)      ,/* 資料創建日 */
fmmemodid       varchar2(20)      ,/* 資料修改者 */
fmmemoddt       timestamp(0)      ,/* 最近修改日 */
fmmestus       varchar2(10)      ,/* 狀態碼 */
fmmeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmme_t add constraint fmme_pk primary key (fmmeent,fmme001) enable validate;

create unique index fmme_pk on fmme_t (fmmeent,fmme001);

grant select on fmme_t to tiptop;
grant update on fmme_t to tiptop;
grant delete on fmme_t to tiptop;
grant insert on fmme_t to tiptop;

exit;
