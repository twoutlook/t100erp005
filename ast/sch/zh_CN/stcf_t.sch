/* 
================================================================================
檔案代號:stcf_t
檔案名稱:分銷合約費用設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcf_t
(
stcfent       number(5)      ,/* 企業編號 */
stcfsite       varchar2(10)      ,/* 營運據點 */
stcfunit       varchar2(10)      ,/* 應用組織 */
stcfseq       number(10,0)      ,/* 項次 */
stcf001       varchar2(20)      ,/* 合約編號 */
stcf002       varchar2(10)      ,/* 費用編號 */
stcf003       varchar2(10)      ,/* 會計期間 */
stcf004       varchar2(10)      ,/* 價款類別 */
stcf005       varchar2(10)      ,/* 計算類型 */
stcf006       varchar2(10)      ,/* 費用週期 */
stcf007       varchar2(10)      ,/* 費用週期方式 */
stcf008       varchar2(10)      ,/* 條件基準 */
stcf009       varchar2(10)      ,/* 計算基準 */
stcf010       number(20,6)      ,/* 費用淨額 */
stcf011       number(20,6)      ,/* 費用比率 */
stcf012       varchar2(10)      ,/* 保底否 */
stcf013       number(20,6)      ,/* 保底金額 */
stcf014       number(20,6)      ,/* 保底扣率 */
stcf015       varchar2(10)      ,/* 分量扣點 */
stcf016       date      ,/* 生效日期 */
stcf017       date      ,/* 失效日期 */
stcf018       date      ,/* 下次計算日 */
stcf019       date      ,/* 下次計算開始日 */
stcf020       date      ,/* 下次計算截止日 */
stcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcf_t add constraint stcf_pk primary key (stcfent,stcfseq,stcf001) enable validate;

create unique index stcf_pk on stcf_t (stcfent,stcfseq,stcf001);

grant select on stcf_t to tiptop;
grant update on stcf_t to tiptop;
grant delete on stcf_t to tiptop;
grant insert on stcf_t to tiptop;

exit;
